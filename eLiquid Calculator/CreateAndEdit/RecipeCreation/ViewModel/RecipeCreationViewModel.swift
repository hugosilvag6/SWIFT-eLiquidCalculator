//
//  RecipeCreationViewModel.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 05/09/22.
//

import SwiftUI
import Firebase

class RecipeCreationViewModel: ObservableObject {
   
   @Published var uiState: RecipeCreationEditUIState = .none
   
   @Published var readyJuice = Juice(type: FlavorType.dessert.rawValue, name: "", description: "", nicotineStrength: "", size: "", desiredStrength: "", pg: "", flavors: [:], author: "", creationDate: "", isPrivate: false)
   @Published var flavorList = [UniqueFlavor]()
   @Published var flavorPG: Double = 50
   var list: [String:String] {
      var sabores = [String:String]()
      for flavor in self.flavorList {
         sabores[flavor.name] = flavor.amount
      }
      return sabores
   }
   
   func creationValidation () {
      
      if self.readyJuice.description.isEmpty {
         self.uiState = .error("Description can't be empty.")
      } else if self.readyJuice.name.isEmpty {
         self.uiState = .error("Name can't be empty.")
      } else if !self.readyJuice.nicotineStrength.isDouble {
         self.uiState = .error("Nicotine strength can't be empty and must contain only numbers.")
      } else if !self.readyJuice.size.isDouble {
         self.uiState = .error("Size can't be empty and must contain only numbers.")
      } else if !self.readyJuice.desiredStrength.isDouble {
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
         self.createRecipe()
      }
   }
   
   func createRecipe () {
      
      self.uiState = .loading
      
      readyJuice.flavors = self.list
      readyJuice.pg = String(format: "%.0f", self.flavorPG)
      
      WebService.createOrUpdateJuice(juice: readyJuice, completion: { result in
         switch result {
         case .error(let msg):
            self.uiState = .error(msg)
         case .success(let msg):
            self.uiState = .success(msg)
            self.readyJuice = Juice(type: FlavorType.dessert.rawValue, name: "", description: "", nicotineStrength: "", size: "", desiredStrength: "", pg: "", flavors: [:], author: "", creationDate: "", isPrivate: false)
            self.flavorList = [UniqueFlavor]()
         }
      })
   }
   
}
