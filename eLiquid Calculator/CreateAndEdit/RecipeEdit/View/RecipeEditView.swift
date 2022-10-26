//
//  RecipeEditView.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 09/09/22.
//

import SwiftUI
import Combine

struct RecipeEditView: View {
   
   @ObservedObject var viewModel: RecipeEditViewModel
   @Binding var showShet: Bool
   
    var body: some View {
       ZStack {
          Color("ThemeMedium")
             .ignoresSafeArea()
       ScrollView {
          VStack (spacing: 10) {
             
             CEImageSection(type: $viewModel.juice.type)
                         
             CEDescriptionSection(text: $viewModel.juice.description)
             
             inputSection
             
             CEFlavorSection(flavorList: $viewModel.flavorList)
             
             if case RecipeCreationEditUIState.success(let msg) = viewModel.uiState {
                Text("")
                   .alert("Success", isPresented: .constant(true)) {
                      Button("Ok") {
                         self.viewModel.uiState = .none
                         self.showShet = false
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
             
             CEPrivateSection(isPrivate: $viewModel.juice.isPrivate)
             
             CECreateButton(uiState: $viewModel.uiState, action: viewModel.updateValidation, isEdit: true)
             
          }
          .padding()
          .padding(.top, 50)
          .overlay (alignment: .topTrailing) {
             Button {
                self.showShet = false
             } label: {
                HStack {
                   Text("Cancel")
                   Image(systemName: "xmark")
                }
             }
             .padding(25)
          }
       }
       }
    }
}

extension RecipeEditView {
   var inputSection: some View {
      VStack {
         SpecificationInput(fieldName: "Name", fieldValue: $viewModel.juice.name)
         SpecificationInput(fieldName: "Nicotine strength", fieldValue: $viewModel.juice.nicotineStrength)
         SpecificationInput(fieldName: "Size", fieldValue: $viewModel.juice.size)
         SpecificationInput(fieldName: "Desired strength", fieldValue: $viewModel.juice.desiredStrength)
         PgSlider(fieldValue: $viewModel.flavorPG)
      }
   }
}

struct RecipeEditView_Previews: PreviewProvider {
    static var previews: some View {
       RecipeEditView(viewModel: RecipeEditViewModel(juice: flavorsData[0], publisher: PassthroughSubject<Juice, Never>()), showShet: .constant(true))
    }
}
