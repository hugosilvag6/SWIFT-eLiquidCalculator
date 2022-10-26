//
//  FlavorCardView.swift
//  eLiquid Recipes
//
//  Created by Hugo Silva on 26/08/22.
//

import SwiftUI

struct FlavorCardView: View {
  
  var flavor: Juice
   var isPublic: Bool
   
   var squareColor: Color {
      if flavor.type == "Minty" {
         return .green
      } else if flavor.type == "Dessert" {
         return .pink
      } else if flavor.type == "Fruity" {
         return .red
      } else {
         return .brown
      }
   }
  
  var body: some View {
    HStack (spacing: 20) {
      
       Text("")
          .frame(width: 90)
      
       VStack (alignment: .leading, spacing: 3) {
          Text(flavor.name)
             .modifier(TextModifier(size: 23))
             .lineLimit(1)
          Text(flavor.description)
             .modifier(TextModifier(size: 13))
             .lineLimit(1)
          VStack (alignment: .leading, spacing: 0) {
             HStack (spacing: 0) {
                Text("Author: ").bold()
                Text(flavor.author)
                   .lineLimit(1)
             }
             HStack (spacing: 0) {
                Text("Changed at: ").bold()
                Text(flavor.creationDate)
             }
          }
          .foregroundColor(Color("ThemeTextLight"))
          .font(.system(size: 13, design: .rounded))
          if !isPublic {
             Text(flavor.isPrivate ? "Private" : "Public")
                .modifier(TextModifier(size: 16))
          }
       }
       
       Spacer()
       
    }
    .frame(maxWidth: .infinity, minHeight: 120)
    .background {
       ZStack {
          RoundedRectangle(cornerRadius: 20)
             .fill(Color("ThemeLight"))
          RoundedRectangle(cornerRadius: 20)
             .stroke(Color("ThemeStroke"), lineWidth: 2)
       }
    }
    .cornerRadius(20)
    .overlay (alignment: .leading) {
       VStack (spacing: 2) {
          Image(flavor.type)
             .resizable()
             .scaledToFit()
             .frame(width: 60, height: 60)
          Text(flavor.type)
             .modifier(TextModifier(size: 13, color: .white))
       }
       .frame(width: 100, height: 100)
       .background {
          RoundedRectangle(cornerRadius: 20)
             .fill(squareColor)
             .shadow(color: Color("ThemeStroke"), radius: 2, x: 2, y: 2)
       }
       .offset(x: -10)
     }
  }
}

struct FlavorCardView_Previews: PreviewProvider {
  static var previews: some View {
     ZStack {
        LinearGradient(gradient: Gradient(colors: [Color("GradientFirstColor"), Color("GradientSecondColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
           .ignoresSafeArea()
        FlavorCardView(flavor: flavorsData[0], isPublic: false)
         .previewLayout(.sizeThatFits)
         .padding()
     }
  }
}
