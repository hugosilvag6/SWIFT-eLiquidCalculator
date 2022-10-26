//
//  ProfileInput.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.
//

import SwiftUI

struct ProfileInput: View {
   
   var fieldName: String
   var fieldImage: String
   @Binding var fieldValue: String
   var uiState: ProfileUIState
   
   @FocusState var clicked: Bool
   @State var inputColor: Color = Color("ThemeStroke")
   @State var edited: Bool = false
   
   var body: some View {
      HStack (spacing: 0) {
         Image(systemName: fieldImage)
            .font(.title2)
            .frame(width: 30, height: 30)
            .foregroundColor(Color("GradientFirstColor"))
         Color("ThemeStroke")
            .frame(width: 1, height: 40)
            .padding(.horizontal)
         VStack (alignment: .leading, spacing: 2) {
            if uiState == .loading {
               HStack {
                  ProgressView()
                  Spacer()
               }
            } else {
               Text(fieldName)
                  .modifier(TextModifier(size: 16, color: Color("ThemeStroke")))
               TextField("", text: $fieldValue)
                  .focused($clicked)
                  .disableAutocorrection(true)
                  .onChange(of: fieldValue) { text in
                     inputValidation(text)
                  }
                  .onDisappear {
                     edited = false
                     inputColor = Color("ThemeStroke")
                  }
                  .modifier(TextModifier(size: 16, weight: .semibold))
            }
         }
      }
      .padding(.vertical, 10)
      .padding(.horizontal)
      .background {
         ZStack {
            if edited {
               RoundedRectangle(cornerRadius: 20)
                  .fill(inputColor.opacity(0.2))
               RoundedRectangle(cornerRadius: 20)
                  .stroke(inputColor,
                          lineWidth: 3)
            } else {
               RoundedRectangle(cornerRadius: 20)
                  .fill(clicked ? inputColor.opacity(0.3) : .clear)
               RoundedRectangle(cornerRadius: 20)
                  .stroke(Color("ThemeStroke"),
                     lineWidth: clicked ? 3 : 1)
            }
         }
      }
   }
}

extension ProfileInput {
   func inputValidation (_ text: String) {
      
      if fieldName == "Phone" && !text.hasPrefix("+ ") && text.count > 1 {
               fieldValue = "+ " + text
      }
      
      if (fieldName == "Email" && !text.isEmail()) ||
            (fieldName == "Full name" && (!text.contains(" ") || text.count < 4)) ||
            (fieldName == "Phone" && text.count < 7) {
         inputColor = .red
      } else {
         inputColor = .green
      }
      edited = true
   }
}

struct ProfileInput_Previews: PreviewProvider {
   static var previews: some View {
      ProfileInput(fieldName: "Email", fieldImage: "envelope", fieldValue: .constant("hugosilvag6@hotmail.com"), uiState: .none)
         .previewLayout(.sizeThatFits)
         .padding()
   }
}
