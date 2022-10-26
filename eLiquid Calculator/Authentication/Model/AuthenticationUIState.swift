//
//  AuthenticationUIState.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.
//

import Foundation

enum AuthenticationUIState: Equatable {
   case none
   case loading
   case success
   case error(String)
}
