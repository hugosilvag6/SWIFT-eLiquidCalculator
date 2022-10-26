//
//  AuthenticationView.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 30/08/22.
//

import SwiftUI

struct AuthenticationView: View {
   
   @ObservedObject var viewModel = AuthenticationViewModel()
   
   var body: some View {
      GeometryReader { geometry in
         ZStack {
            authBackground
            ScrollView {
               VStack (spacing: 20) {
                  if viewModel.isSignIn {
                     ProfileImage(strokeColor: .white, image: $viewModel.profileImage, profileUrl: .constant(""))
                     authTitle
                     authSignupScreen
                  } else {
                     AppLogotipo()
                     authTitle
                     authLoginScreen
                  }
                  authSwitchButton
               }
               .frame(minHeight: geometry.size.height)
               .padding(.horizontal, 20)
            }
         }
         
         if case AuthenticationUIState.error(let msg) = viewModel.uiState {
            Text("")
               .alert("Error", isPresented: .constant(true)) {
                  Button("Ok") {
                     self.viewModel.uiState = .none
                  }
               } message: {
                  Text(msg)
               }
         }
         
         
      } // geometry
   } // body
} // view

extension AuthenticationView {
   var authBackground: some View {
      LinearGradient(gradient: Gradient(colors: [Color("GradientFirstColor"), Color("GradientSecondColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
         .ignoresSafeArea()
   }
   var authTitle: some View {
      Text(viewModel.isSignIn ? "Register".uppercased() : "Login".uppercased())
         .font(.system(size: 30, weight: .bold, design: .rounded))
         .foregroundColor(.white)
         .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 2, x: 2, y: 2)
         .padding(.vertical, 40)
         .frame(maxWidth: .infinity)
   }
   var authLoginScreen: some View {
      Group {
         TextField("", text: $viewModel.email)
            .modifier(AuthInputModifier(value: viewModel.email, name: "Email", img: "envelope"))
            .textInputAutocapitalization(.never)
         SecureField("", text: $viewModel.password)
            .modifier(AuthInputModifier(value: viewModel.password, name: "Password", img: "key"))
         AuthButtonView(action: { self.viewModel.login() },
                        text: "Login",
                        showProgress: self.viewModel.uiState == AuthenticationUIState.loading)
      }
   }
   var authSignupScreen: some View {
      Group {
         TextField("", text: $viewModel.name)
            .modifier(AuthInputModifier(value: viewModel.name, name: "Full name", img: "person"))
         TextField("", text: $viewModel.email)
            .modifier(AuthInputModifier(value: viewModel.email, name: "Email", img: "envelope"))
            .textInputAutocapitalization(.never)
         SecureField("", text: $viewModel.password)
            .modifier(AuthInputModifier(value: viewModel.password, name: "Password", img: "key"))
         AuthButtonView(action: { self.viewModel.registerValidation() },
                        text: "Sign up",
                        showProgress: self.viewModel.uiState == AuthenticationUIState.loading)
      }
   }
   var authSwitchButton: some View {
      Button {
         viewModel.isSignIn.toggle()
      } label: {
         if viewModel.isSignIn {
            Text("Already have an account? ")
            + Text("Login!")
               .bold()
               .underline()
         } else {
            Text("Don't have an account? ")
            + Text("Register now!")
               .bold()
               .underline()
         }
      }
      .foregroundColor(.white)
   }
}

struct AuthenticationView_Previews: PreviewProvider {
   static var previews: some View {
      AuthenticationView(viewModel: AuthenticationViewModel())
   }
}
