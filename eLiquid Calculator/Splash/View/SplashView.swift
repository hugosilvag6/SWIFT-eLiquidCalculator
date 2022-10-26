//
//  SplashView.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.
//

import SwiftUI

struct SplashView: View {
  
  @ObservedObject var viewModel = SplashViewModel()
   
   init () {

      UITextView.appearance().backgroundColor = .clear
   }
  
    var body: some View {
      ZStack {
        if case SplashUIState.loading = viewModel.uiState {
          LinearGradient(gradient: Gradient(colors: [Color("GradientFirstColor"), Color("GradientSecondColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
              .ignoresSafeArea()
          AppLogotipo()
        } else if case SplashUIState.toLogin = viewModel.uiState {
          AuthenticationView()
        } else if case SplashUIState.toHome = viewModel.uiState {
          HomeView()
        }
      }.onAppear {
        viewModel.onAppear()
      }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
