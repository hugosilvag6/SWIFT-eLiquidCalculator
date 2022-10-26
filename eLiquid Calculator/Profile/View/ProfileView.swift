//
//  ProfileView.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.}

import SwiftUI
import Firebase

struct ProfileView: View {
   
   @ObservedObject var viewModel = ProfileViewModel()
   
   var body: some View {
      ZStack {
         Color("ThemeMedium")
            .ignoresSafeArea()
         
         ScrollView {
            VStack (spacing: 20) {
               ProfileImage(strokeColor: Color("GradientFirstColor"),
                            image: $viewModel.displayProfile.profileImage,
                            profileUrl: $viewModel.displayProfile.profileUrl)
               joinedSection
               inputSection
               Spacer()
               
               if case ProfileUIState.success(let msg) = viewModel.uiState {
                  Text("")
                     .alert("Success", isPresented: .constant(true)) {
                        Button("Ok") {
                           self.viewModel.uiState = .none
                        }
                     } message: {
                        Text(msg)
                     }
               } else if case ProfileUIState.error(let msg) = viewModel.uiState {
                  Text("")
                     .alert("Error", isPresented: .constant(true)) {
                        Button("Ok") {
                           self.viewModel.uiState = .none
                        }
                     } message: {
                        Text(msg)
                     }
               }
               
               Spacer()
               
               buttonSection
            }
            .padding()
            .onAppear {
               viewModel.fetchProfile()
            }
         }
      }
   }
}

extension ProfileView {
   var joinedSection: some View {
      Group {
         if viewModel.displayProfile.joinDate.count > 0 {
            HStack {
               Text("Joined ")
                  .modifier(TextModifier(size: 18, color: Color("ThemeStroke")))
               Text(viewModel.displayProfile.joinDate).bold()
                  .modifier(TextModifier(size: 18))
            }
         } else {
            ProgressView()
         }
      }
      .padding(.vertical, 30)
   }
   var inputSection: some View {
      Group {
         ProfileInput(fieldName: "Full name", fieldImage: "person", fieldValue: $viewModel.displayProfile.name, uiState: viewModel.uiState)
         ProfileInput(fieldName: "Email", fieldImage: "envelope", fieldValue: $viewModel.displayProfile.email, uiState: viewModel.uiState)
         ProfileInput(fieldName: "Phone", fieldImage: "iphone.homebutton", fieldValue: $viewModel.displayProfile.phone, uiState: viewModel.uiState)
      }
   }
   var buttonSection: some View {
      HStack {
         ProfileButton(action: {try? Auth.auth().signOut()},
                       fillColor: Color("ThemeLight"),
                       textColor: .black,
                       icon: "rectangle.portrait.and.arrow.right",
                       text: "Sign out",
                       disabled: false)
         ProfileButton(action: {await viewModel.updateUser()}, fillColor: .black, textColor: .white, icon: "arrow.triangle.2.circlepath", text: "Update", disabled: !viewModel.displayProfile.email.isEmail() ||
                       (!viewModel.displayProfile.name.contains(" ") || viewModel.displayProfile.name.count < 4) ||
                       viewModel.displayProfile.phone.count < 7 ||
                       viewModel.displayProfile == viewModel.fetchedProfile)
      }
      .frame(height: 70)
   }
}

struct ProfileView_Previews: PreviewProvider {
   static var previews: some View {
      ProfileView()
   }
}
