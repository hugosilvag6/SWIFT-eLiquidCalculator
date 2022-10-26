//
//  RecipeCreationView.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 05/09/22.
//

import SwiftUI

struct RecipeCreationView: View {
   
   @ObservedObject var viewModel = RecipeCreationViewModel()
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
   var body: some View {
      ZStack {
         Color("ThemeMedium")
            .ignoresSafeArea()
      ScrollView {
         VStack (spacing: 10) {
            
            CEImageSection(type: $viewModel.readyJuice.type)
                      
            CEDescriptionSection(text: $viewModel.readyJuice.description)
            
            inputSection
            
            CEFlavorSection(flavorList: $viewModel.flavorList)
            
            if case RecipeCreationEditUIState.success(let msg) = viewModel.uiState {
               Text("")
                  .alert("Success", isPresented: .constant(true)) {
                     Button("Ok") {
                        self.viewModel.uiState = .none
                        self.presentationMode.wrappedValue.dismiss()
                     }
                  } message: {
                     Text(msg)
                  }
            } else if case RecipeCreationEditUIState.error(let msg) = viewModel.uiState {
               Text("")
                  .alert("Error", isPresented: .constant(true)) {
                     Button("Ok") {
                        self.viewModel.uiState = .none
                     }
                  } message: {
                     Text(msg)
                  }
            }
            
            CEPrivateSection(isPrivate: $viewModel.readyJuice.isPrivate)
            
            CECreateButton(uiState: $viewModel.uiState, action: viewModel.creationValidation, isEdit: false)
            
         }
         .padding()
      }
      }
   }
}

extension RecipeCreationView {
   var inputSection: some View {
      VStack {
         SpecificationInput(fieldName: "Name", fieldValue: $viewModel.readyJuice.name)
         SpecificationInput(fieldName: "Nicotine strength", fieldValue: $viewModel.readyJuice.nicotineStrength)
         SpecificationInput(fieldName: "Size", fieldValue: $viewModel.readyJuice.size)
         SpecificationInput(fieldName: "Desired strength", fieldValue: $viewModel.readyJuice.desiredStrength)
         PgSlider(fieldValue: $viewModel.flavorPG)
      }
   }
}

struct RecipeCreationView_Previews: PreviewProvider {
   static var previews: some View {
      RecipeCreationView()
   }
}
