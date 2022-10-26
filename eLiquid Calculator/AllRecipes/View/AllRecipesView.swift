//
//  ContentView.swift
//  eLiquid Recipes
//
//  Created by Hugo Silva on 26/08/22.
//

import SwiftUI
import Firebase

struct AllRecipesView: View {
   
   @ObservedObject var viewModel = AllRecipesViewModel()
   
    var body: some View {
       NavigationView {
          ZStack {
             Color("ThemeMedium")
                .ignoresSafeArea()
            
             ScrollView {
                LazyVStack (spacing: 15) {
                   
                   statistics
                   
                   ForEach(viewModel.fetchedFlavors) { item in
                      NavigationLink {
                         RecipeScreenView(viewModel: RecipeScreenViewModel(juice: item, isEditable: false))
                      } label: {
                        FlavorCardView(flavor: item, isPublic: true)
                      }
                   }
                   
                   Spacer()
                }
                .padding(.horizontal, 25)
                .padding(.top, 25)
             }
             
             
             
             
          }
          .navigationTitle("All Recipes")
          .navigationBarTitleDisplayMode(.inline)
          .onAppear {
             viewModel.fetchAllRecipes()
          }
       }
       .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension AllRecipesView {
   var statistics: some View {
      VStack (spacing: 20) {
         Text("Public Recipes")
            .modifier(TextModifier(size: 25))
         HStack (spacing: 15) {
            statisticsField(f1: "Public", f2: "recipes", data: viewModel.statisticsData["public"]!)
            statisticsField(f1: "Total", f2: "users", data: viewModel.statisticsData["users"]!)
         }
      }
      .padding(25)
      .frame(maxWidth: .infinity, minHeight: 100)
      .background {
         ZStack {
            RoundedRectangle(cornerRadius: 20)
               .fill(Color("ThemeMedium"))
            RoundedRectangle(cornerRadius: 20)
               .stroke(Color("ThemeStroke"), lineWidth: 2)
         }
      }
   }
   func statisticsField (f1: String, f2: String, data: Int) -> some View {
      VStack {
         Text(f1)
            .modifier(TextModifier())
         Text(f2)
            .modifier(TextModifier())
         Text("\(data)")
            .modifier(TextModifier(size: 25))
            .padding(.top, 1)
      }
      .frame(maxWidth: 70)
      .padding(10)
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

struct AllRecipesView_Previews: PreviewProvider {
    static var previews: some View {
       AllRecipesView()
    }
}
