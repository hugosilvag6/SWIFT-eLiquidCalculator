//
//  SpecificationInput.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 05/09/22.
//

import SwiftUI

struct SpecificationInput: View {
   
   var fieldName: String
   @Binding var fieldValue: String
   
   var body: some View {
      VStack {
         HStack {
            Text(fieldName)
               .modifier(TextModifier(size: 20))
            TextField("", text: $fieldValue)
               .multilineTextAlignment(.trailing)
               .modifier(TextModifier(size: 20, weight: .regular))
               .disableAutocorrection(true)
               .modifier(Placeholder(value: fieldValue))
         }
         Rectangle()
            .fill(Color("ThemeStroke"))
            .frame(height: 1)
      }
      .padding(.top)
   }
}

struct SpecificationInput_Previews: PreviewProvider {
   static var previews: some View {
      SpecificationInput(fieldName: "Name", fieldValue: .constant("Vanilla Cupcake"))
         .previewLayout(.sizeThatFits)
         .padding()
   }
}
