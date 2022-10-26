//
//  TextModifier.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 12/09/22.
//

import SwiftUI

struct TextModifier: ViewModifier {
   
   var size: CGFloat?
   var weight: Font.Weight?
   var design: Font.Design?
   var color: Color?
   
   
   func body(content: Content) -> some View {
      content
         .font(.system(size: size != nil ? size! : 16,
                       weight: weight != nil ? weight! : .bold,
                       design: design != nil ? design! : .rounded))
         .foregroundColor(color != nil ? color : Color("ThemeText"))
   }
}

