//
//  DescriptionCreateEdit.swift/Users/hugosilva/Documents/Projetos Swift/eLiquid Recipes/eLiquid Calculator/CreateAndEdit/Components/DescriptionCreateEdit.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 12/09/22.
//

import SwiftUI

struct CEDescriptionSection: View {
   
   @Binding var text: String
   
   var body: some View {
      VStack (alignment: .leading) {
         Text("Description")
            .modifier(TextModifier(size: 20))
         TextField("", text: $text)
            .modifier(TextModifier(size: 20, weight: .regular))
            .autocorrectionDisabled(true)
            .modifier(Placeholder(value: text, alignment: .leading))
         Rectangle()
            .fill(Color("ThemeStroke"))
            .frame(height: 1)
      }
      .onAppear {
         UITextView.appearance().backgroundColor = .clear
      }
   }
}

struct CEDescriptionSection_Previews: PreviewProvider {
   static var previews: some View {
      CEDescriptionSection(text: .constant(""))
   }
}
