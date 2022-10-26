//
//  AppLogotipo.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.
//

import SwiftUI

struct AppLogotipo: View {
    var body: some View {
      HStack(spacing: 35) {
        RoundedRectangle(cornerRadius: 20)
          .fill(.white.opacity(0.2))
          .frame(width: 130, height: 130)
          .rotationEffect(.degrees(45))
          .overlay {
            Image("login-icon")
              .renderingMode(.template)
              .resizable()
              .scaledToFit()
              .frame(width: 80, height: 80)
              .foregroundColor(.white)
              .rotationEffect(.degrees(15))
              .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 2, x: 2, y: 2)
          }
        VStack(alignment: .leading) {
          Text("eLiquid".uppercased())
            .font(.largeTitle.bold())
          Text("Calculator".uppercased())
            .font(.subheadline)
            .offset(y: -6)
          Text("For vapers. By vapers.".uppercased())
            .font(.system(size: 11, weight: .bold, design: .rounded))
        }
        .foregroundColor(.white)
      }
    }
}

struct AppLogotipo_Previews: PreviewProvider {
    static var previews: some View {
        AppLogotipo()
        .previewLayout(.sizeThatFits)
        .background {
          LinearGradient(gradient: Gradient(colors: [Color("GradientFirstColor"), Color("GradientSecondColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}
