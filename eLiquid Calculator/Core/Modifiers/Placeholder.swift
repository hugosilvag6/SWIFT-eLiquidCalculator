//
//  Placeholder.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 12/09/22.
//

import SwiftUI

struct Placeholder: ViewModifier {
   
   var value: String
   var alignment: Alignment?
   
   func body(content: Content) -> some View {
      ZStack (alignment: alignment != nil ? alignment! : .trailing) {
         if value.isEmpty {
            Text("Enter")
               .modifier(TextModifier(size: 20, color: Color("ThemeStroke")))
         }
         content
      }
   }
}

