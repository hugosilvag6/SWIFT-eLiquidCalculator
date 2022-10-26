//
//  CECreateButton.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 12/09/22.
//

import SwiftUI

struct CECreateButton: View {
   
   @Binding var uiState: RecipeCreationEditUIState
   var action: () -> Void
   var isEdit: Bool
   
    var body: some View {
       Button {
          action()
       } label: {
          Group {
             if uiState != .loading {
                Text(isEdit ? "Update" : "Create")
                   .modifier(TextModifier(size: 20, color: .white))
             } else {
                ProgressView()
             }
          }
             .padding()
             .foregroundColor(.white)
             .frame(maxWidth: .infinity, maxHeight: 50)
             .background {
                Color("GradientFirstColor")
                   .cornerRadius(20)
             }
       }
    }
}

struct CECreateButton_Previews: PreviewProvider {
    static var previews: some View {
       CECreateButton(uiState: .constant(.none), action: {print("teste")}, isEdit: true)
    }
}
