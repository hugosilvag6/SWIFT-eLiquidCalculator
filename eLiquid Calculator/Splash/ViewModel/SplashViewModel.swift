//
//  SplashViewModel.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.
//

import SwiftUI
import Firebase

class SplashViewModel: ObservableObject {
   
   @Published var uiState: SplashUIState = .loading
   
   func onAppear() {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
         Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
               self.uiState = .toHome
            } else {
               self.uiState = .toLogin
            }
         }
      }
   }
   
}
