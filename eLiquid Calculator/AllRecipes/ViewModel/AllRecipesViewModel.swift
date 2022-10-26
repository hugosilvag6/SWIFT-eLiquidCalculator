//
//  AllRecipesViewModel.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 06/09/22.
//

import Foundation
import Firebase

class AllRecipesViewModel: ObservableObject {
   
   @Published var fetchedFlavors = [Juice]()
   @Published var statisticsData: [String:Int] = ["users":0, "public":0]
   
   
   func fetchAllRecipes () {
//      self.uiState = .loading
      fetchedFlavors.removeAll()
      WebService.fetchRecipes(isPublic: true) { result in
         switch result {
         case .error(let msg):
            print(msg)
         case .success(let recipes):
            for recipe in recipes {
               self.fetchedFlavors.append(recipe)
            }
            self.statisticsData["public"] = self.fetchedFlavors.count
         }
      }
      
      WebService.numberOfUsers { users in
         self.statisticsData["users"] = users
      }
   }
   
}
