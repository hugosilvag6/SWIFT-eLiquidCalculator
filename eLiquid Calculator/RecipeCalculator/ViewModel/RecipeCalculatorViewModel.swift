//
//  RecipeCalculatorViewModel.swift
//  eLiquid Recipes
//
//  Created by Hugo Silva on 29/08/22.
//

import SwiftUI
import Combine

class RecipeCalculatorViewModel: ObservableObject {
  
  var flavor: Juice
  
  init (flavor: Juice) {
    self.flavor = flavor
     
     self.nicotineStrengthInput = flavor.nicotineStrength
     self.sizeInput = flavor.size
     self.desiredStrengthInput = flavor.desiredStrength
     self.pgInput = flavor.pg
  }
  
   @Published var nicotineStrengthInput: String = ""
  var nicotineStrength: Double {
    Double(nicotineStrengthInput) ?? 250
  }
  @Published var sizeInput: String = ""
  var size: Double {
    Double(sizeInput) ?? 30
  }
  @Published var desiredStrengthInput: String = ""
  var desiredStrength: Double {
    Double(desiredStrengthInput) ?? 30
  }
  @Published var pgInput: String = ""
  var pgAmount: Double {
    Double(pgInput) ?? 50
  }
  var nicotineResult: Double {
    desiredStrength * (size/nicotineStrength)
  }
  var pgResult: Double {
    size - vgResult - totalFlavor - nicotineResult
  }
  var vgResult: Double {
    size - (size*pgAmount/100)
  }
  var totalFlavor: Double {
    var total: Double = 0
    for flavor in flavor.flavors.values {
      total += Double(flavor) ?? 0
    }
    return total*size/100
  }
  
}
