//
//  MyRecipesViewModel.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 05/09/22.
//

import SwiftUI

class MyRecipesViewModel: ObservableObject {

   @Published var fetchedFlavors = [Juice]()
   
   func fetchPrivateRecipes () {
//      self.uiState = .loading
      fetchedFlavors.removeAll()
      WebService.fetchRecipes(isPublic: false) { result in
         switch result {
         case .error(let msg):
            print(msg)
         case .success(let recipes):
            for recipe in recipes {
               self.fetchedFlavors.append(recipe)
            }
         }
      }
   }
   
}
