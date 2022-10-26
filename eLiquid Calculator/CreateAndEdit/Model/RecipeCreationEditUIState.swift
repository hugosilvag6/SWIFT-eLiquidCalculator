//
//  RecipeCreationEditUIState.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 12/09/22.
//

import Foundation

enum RecipeCreationEditUIState: Equatable {
   case none
   case loading
   case success(String)
   case error(String)
}
