//
//  MyRecipesView.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 03/09/22.
//

import SwiftUI

struct MyRecipesView: View {
   
   @ObservedObject var viewModel = MyRecipesViewModel()
   
    var body: some View {
       NavigationView {
          ZStack {
             Color("ThemeMedium")
                .ignoresSafeArea()
            
             ScrollView {
                VStack (spacing: 15) {
                   ForEach(viewModel.fetchedFlavors) { item in
                      NavigationLink {
                        RecipeScreenView(viewModel: RecipeScreenViewModel(juice: item, isEditable: true))
                      } label: {
                        FlavorCardView(flavor: item, isPublic: false)
                      }
                   }
                   
                   Spacer()
                }
                .padding(.horizontal, 25)
                .padding(.top, 25)
             }
             
          }
          .toolbar {
                NavigationLink {
                   RecipeCreationView()
                } label: {
                   Image(systemName: "plus.circle")
                      .modifier(TextModifier(size: 20))
                }
          }
          .navigationTitle("My Recipes")
          .navigationBarTitleDisplayMode(.inline)
          .onAppear {
             viewModel.fetchPrivateRecipes()
          }
       }
       .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MyRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipesView()
    }
}


