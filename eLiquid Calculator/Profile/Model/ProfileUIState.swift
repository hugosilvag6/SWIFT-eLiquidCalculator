//
//  ProfileUIState.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.
//

import Foundation

enum ProfileUIState: Equatable {
   case none
   case loading
   case success(String)
   case error(String)
}
