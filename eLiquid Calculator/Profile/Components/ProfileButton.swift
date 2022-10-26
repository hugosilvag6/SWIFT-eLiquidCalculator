//
//  ProfileButton.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.
//

import SwiftUI

struct ProfileButton: View {
   
   var action: () async -> Void
   var fillColor: Color
   var textColor: Color
   var icon: String
   var text: String
   var disabled: Bool
   
   var body: some View {
      RoundedRectangle(cornerRadius: 20)
         .fill(disabled ? fillColor.opacity(0.5) : fillColor)
         .overlay {
            Button {
               Task {
                  await action()
               }
            } label: {
               HStack (spacing: 10) {
                  Image(systemName: icon)
                     .font(.title)
                     .foregroundColor(textColor == .white ? .white : Color("GradientFirstColor"))
                  Text(text)
                     .font(.title3.bold())
                     .foregroundColor(textColor)
               }
            }
            .disabled(disabled)
         }
   }
}

struct ProfileButton_Previews: PreviewProvider {
   static var previews: some View {
      ProfileButton(action: {print("teste")}, fillColor: .init(white: 0.85), textColor: .black, icon: "rectangle.portrait.and.arrow.right", text: "Sign out", disabled: true)
         .previewLayout(.sizeThatFits)
   }
}
