//
//  HomeView.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.
//

import SwiftUI

struct HomeView: View {
   
   var body: some View {
         TabView {
               AllRecipesView()
                  .tabItem {
                     Image(systemName: "square.grid.2x2")
                     Text("Recipes")
                  }
               MyRecipesView()
                  .tabItem {
                     Image(systemName: "rectangle.stack.badge.person.crop")
                     Text("My recipes")
                  }
               ProfileView()
                  .tabItem {
                     Image(systemName: "person.crop.circle")
                     Text("Profile")
                  }
         }
   }
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}
