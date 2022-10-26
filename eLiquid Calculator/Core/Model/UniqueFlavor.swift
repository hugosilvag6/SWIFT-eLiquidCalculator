//
//  UniqueFlavor.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 06/09/22.
//

import Foundation

struct UniqueFlavor: Identifiable, Decodable, Hashable {
   var id = UUID()
   var name: String
   var amount: String
}
