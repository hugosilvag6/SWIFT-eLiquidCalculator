//
//  TypeImageCreateEdit.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 12/09/22.
//

import SwiftUI

struct CEImageSection: View {
   
   @Binding var type: String
   var color: Color {
      if type == "Minty" {
         return .green
      } else if type == "Dessert" {
         return .pink
      } else if type == "Fruity" {
         return .red
      } else {
         return .brown
      }
   }
   
   var body: some View {
      VStack (spacing: 2) {
         Image(type)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
         Picker("Flavor type:", selection: $type) {
            ForEach(FlavorType.allCases, id: \.id) { item in
               Text(item.rawValue)
            }
         }
         .accentColor(.white)
      }
      .background {
         RoundedRectangle(cornerRadius: 20)
            .fill(color)
            .frame(width: 100, height: 100)
            .shadow(color: Color("ThemeStroke"), radius: 2, x: 2, y: 2)
            .overlay (alignment: .bottomTrailing) {
               Image(systemName: "pencil")
                  .foregroundColor(.white)
                  .background {
                     Color("GradientFirstColor")
                        .frame(width: 30, height: 30)
                        .cornerRadius(100)
                  }
                  .shadow(color: .black, radius: 6, x: 0, y: 0)
            }
         
      }
      .padding(.bottom, 40)
   }
}

struct CEImageSection_Previews: PreviewProvider {
   static var previews: some View {
      CEImageSection(type: .constant("Dessert"))
   }
}
