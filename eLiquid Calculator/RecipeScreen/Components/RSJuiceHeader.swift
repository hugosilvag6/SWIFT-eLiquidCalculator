//
//  RSJuiceHeader.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 12/09/22.
//

import SwiftUI

struct RSJuiceHeader: View {
   
   var type: String
   var name: String
   var author: String
   var date: String
   var isPrivate: Bool
   
   var squareColor: Color {
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
       HStack (spacing: 25) {
          VStack (spacing: 2) {
             Image(type)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
             Text(type)
                .foregroundColor(.white)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .shadow(color: Color("ThemeStrong"), radius: 2, x: 2, y: 2)
          }
          .frame(width: 90, height: 90)
          .background {
             RoundedRectangle(cornerRadius: 20)
                .fill(squareColor)
                .shadow(color: Color("ThemeStroke"), radius: 2, x: 2, y: 2)
          }
          VStack (alignment: .leading, spacing: 0) {
             Text(name)
                .modifier(TextModifier(size: 23))
                .lineLimit(1)
             VStack (alignment: .leading, spacing: 0) {
                HStack (spacing: 0) {
                   Text("Author: ").bold()
                   Text(author)
                }
                HStack (spacing: 0) {
                   Text("Changed at: ").bold()
                   Text(date)
                }
             }
             .lineLimit(1)
             .foregroundColor(Color("ThemeTextLight"))
             .font(.system(size: 13, design: .rounded))
             Text(isPrivate ? "Private" : "Public")
                .modifier(TextModifier(size: 16))
          }
          Spacer()
       }
       .padding()
       .frame(maxWidth: .infinity)
       .background {
          ZStack {
             RoundedRectangle(cornerRadius: 20)
                .fill(Color("ThemeLight"))
             RoundedRectangle(cornerRadius: 20)
                .stroke(Color("ThemeStroke"), lineWidth: 2)
          }
       }
    }
}

struct RSJuiceHeader_Previews: PreviewProvider {
    static var previews: some View {
        RSJuiceHeader(type: "Dessert", name: "Vanilla Cupcake", author: "Hugo", date: "2 sep 2022", isPrivate: true)
    }
}
