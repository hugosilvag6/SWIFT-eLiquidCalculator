//
//  RecipeEditViewModel.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 09/09/22.
//

import SwiftUI
import Combine

class RecipeEditViewModel: ObservableObject {
   
   @Published var uiState: RecipeCreationEditUIState = .none
   
   @Published var juice: Juice
   
   var p: PassthroughSubject<Juice, Never>
   
   @Published var flavorPG: Double
   @Published var flavorList = [UniqueFlavor]()
   var list: [String:String] {
      var sabores = [String:String]()
      for flavor in self.flavorList {
         sabores[flavor.name] = flavor.amount
      }
      return sabores
   }
   
   init (juice: Juice, publisher: PassthroughSubject<Juice, Never>) {
      
      self.juice = juice
      self.flavorPG = Double(juice.pg) ?? 50
      self.p = publisher
      
      for flavor in juice.flavors {
         flavorList.append(UniqueFlavor(name: flavor.key, amount: flavor.value))
      }
      
   }
   
   func updateValidation () {
      if self.juice.description.isEmpty {
         self.uiState = .error("Description can't be empty.")
      } else if self.juice.name.isEmpty {
         self.uiState = .error("Name can't be empty.")
      } else if !self.juice.nicotineStrength.isDouble {
         self.uiState = .error("Nicotine strength can't be empty and must contain only numbers.")
      } else if !self.juice.size.isDouble {
         self.uiState = .error("Size can't be empty and must contain only numbers.")
      } else if !self.juice.desiredStrength.isDouble {
         self.uiState = .error("Desired strength can't be empty and must contain only numbers.")
      } else if self.flavorList.isEmpty {
         self.uiState = .error("You must add at least one flavor.")
      } else {
         for flavor in self.flavorList {
            if !flavor.amount.isDouble || flavor.name.isEmpty {
               self.uiState = .error("Flavor name can't be empty and the amount must contain only numbers.")
               return
            }
         }
         self.updateRecipe()
      }
   }
   
   func updateRecipe () {
      self.uiState = .loading
      
      self.juice.flavors = self.list
      self.juice.pg = String(format: "%.0f", self.flavorPG)
      
      if self.juice.isPrivate {
         WebService.makeJuicePrivate(juiceId: self.juice.id)
      }
      
      WebService.createOrUpdateJuice(juice: self.juice, completion: { result in
         switch result {
         case .error(let msg):
            self.uiState = .error(msg)
         case .success(_):
            self.p.send(self.juice)
//            self.uiState = .success("Juice edited.")
         }
      })
   }
}
