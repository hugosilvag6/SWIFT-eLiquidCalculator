//
//  RecipeScreenViewModel.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 08/09/22.
//

import SwiftUI
import Combine

class RecipeScreenViewModel: ObservableObject {
   
   @Published var juice: Juice
   @Published var showSheet = false
   var isEditable: Bool
   let publisher = PassthroughSubject<Juice, Never>()
   var cancellable: AnyCancellable?
   
   init (juice: Juice, isEditable: Bool) {
      self.juice = juice
      self.isEditable = isEditable
      
      self.nicotineStrengthInput = juice.nicotineStrength
      self.sizeInput = juice.size
      self.desiredStrengthInput = juice.desiredStrength
      self.pgInput = juice.pg
      
      cancellable = publisher.sink { value in
         self.juice = value
         self.showSheet = false
      }
   }
   
   deinit {
      cancellable?.cancel()
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
     for flavor in juice.flavors.values {
       total += Double(flavor) ?? 0
     }
     return total*size/100
   }
   
   
}
