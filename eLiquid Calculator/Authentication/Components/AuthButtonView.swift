//
//  AuthButtonView.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 30/08/22.
//

import SwiftUI

struct AuthButtonView: View {
  
  var action: () -> Void
  var text: String
  var showProgress: Bool = true
  
  var body: some View {
    ZStack {
      
      Button {
        action()
      } label: {
        RoundedRectangle(cornerRadius: 30)
          .fill(.white)
          .frame(height: 55)
          .overlay (alignment: .center) {
            Text(showProgress ? "" : text.uppercased())
              .foregroundColor(Color("GradientFirstColor"))
              .bold()
          }
      }
      
      ProgressView()
        .opacity(showProgress ? 1 : 0)
        .progressViewStyle(CircularProgressViewStyle(tint: Color("GradientFirstColor")))
    }
  }
}

struct AuthButtonView_Previews: PreviewProvider {
  static var previews: some View {
    AuthButtonView(action: {print("Hello world")}, text: "Login", showProgress: true)
      .previewLayout(.sizeThatFits)
    AuthButtonView(action: {print("Hello world")}, text: "Login", showProgress: false)
      .previewLayout(.sizeThatFits)
  }
}
