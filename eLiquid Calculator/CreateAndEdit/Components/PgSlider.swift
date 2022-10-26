//
//  PgSlider.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 09/09/22.
//

import SwiftUI

struct PgSlider: View {
   
   @Binding var fieldValue: Double
   
   var body: some View {
      VStack {
         HStack {
            Text("PG amount")
               .modifier(TextModifier(size: 20))
            Spacer()
            Text("\(String(format: "%.0f", fieldValue))%")
               .modifier(TextModifier(size: 20, weight: .semibold))
         }
         Slider(value: $fieldValue, in: 0...100, step: 1)
            .padding(.bottom, 10)
         Rectangle()
            .fill(Color("ThemeStroke"))
            .frame(height: 1)
      }
      .padding(.top)
   }
}

struct PgSlider_Previews: PreviewProvider {
   static var previews: some View {
      PgSlider(fieldValue: .constant(50))
   }
}
