//
//  InputView.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 30/08/22.
//

import SwiftUI

struct AuthInputModifier: ViewModifier {
  
  var value: String
  var name: String
  var img: String
  
  func body(content: Content) -> some View {
        content
        .padding(.horizontal, 70)
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .frame(height: 55)
        .autocorrectionDisabled(true)
        .background {
          ZStack {
            if value.isEmpty {
              Text(name)
                .foregroundColor(.white)
            }
            RoundedRectangle(cornerRadius: 30)
              .stroke(.white, lineWidth: 1)
              .background {
                RoundedRectangle(cornerRadius: 30)
                  .fill(.white.opacity(0.2))
              }
              .overlay (alignment: .leading) {
                Circle()
                  .fill(.white)
                  .frame(width: 60, height: 60)
                  .overlay (alignment: .center) {
                    Image(systemName: img)
                      .foregroundColor(Color("GradientFirstColor"))
                  }
            }
          }
        }
    }
}


struct InputView_Previews: PreviewProvider {
  static var previews: some View {
    TextField("", text: .constant("Email"))
      .modifier(AuthInputModifier(value: "", name: "Email", img: "envelope"))
      .previewLayout(.sizeThatFits)
      .background {
        LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
      }
  }
}
