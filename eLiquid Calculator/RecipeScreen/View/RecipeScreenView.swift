//
//  RecipeScreenView.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 08/09/22.
//

import SwiftUI

struct RecipeScreenView: View {
   
   @ObservedObject var viewModel: RecipeScreenViewModel
   
   var body: some View {
      ZStack {
         Color("ThemeMedium")
            .ignoresSafeArea()
         
         ScrollView {
            VStack {
               RSJuiceHeader(type: viewModel.juice.type,
                             name: viewModel.juice.name,
                             author: viewModel.juice.author,
                             date: viewModel.juice.creationDate,
                             isPrivate: viewModel.juice.isPrivate)
               juiceDescription
               juiceSpecifications
               juiceResult
               Spacer()
            }
            .padding()
         }
         
      }
      .navigationTitle("Recipe")
      .toolbar {
         if viewModel.isEditable {
            Button {
               viewModel.showSheet = true
            } label: {
               HStack {
                  Text("Edit")
                  Image(systemName: "pencil")
               }
            }
         }
      }
      .sheet(isPresented: $viewModel.showSheet) {
         RecipeEditView(viewModel: RecipeEditViewModel(juice: viewModel.juice, publisher: viewModel.publisher), showShet: $viewModel.showSheet)
      }
   }
}

extension RecipeScreenView {
   var juiceDescription: some View {
      Text(viewModel.juice.description)
         .modifier(TextModifier(size: 16, weight: .regular))
         .frame(maxWidth: .infinity)
         .multilineTextAlignment(.leading)
         .padding()
         .background {
            ZStack {
               RoundedRectangle(cornerRadius: 20)
                  .fill(Color("ThemeLight"))
               RoundedRectangle(cornerRadius: 20)
                  .stroke(Color("ThemeStroke"), lineWidth: 2)
            }
         }
   }
   var juiceSpecifications: some View {
      VStack (alignment: .leading) {
         VStack (alignment: .leading, spacing: 10) {
            Text("Specifications")
               .modifier(TextModifier(size: 20))
            HStack {
               Text("Nicotine strength")
               Spacer()
               Text("\(viewModel.juice.nicotineStrength)mg")
            }
            HStack {
               Text("Desired strength")
               Spacer()
               Text("\(viewModel.juice.desiredStrength)mg")
            }
            HStack {
               Text("Size")
               Spacer()
               Text("\(viewModel.juice.size)ml")
            }
            HStack {
               Text("PG")
               Spacer()
               Text("\(viewModel.juice.pg)%")
            }
         }
         .modifier(TextModifier(size: 16, weight: .regular))
         .padding()
         .frame(maxWidth: .infinity)
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
   var juiceResult: some View {
      VStack (alignment: .leading) {
         VStack (alignment: .leading, spacing: 10) {
            Text("Result")
               .modifier(TextModifier(size: 20))
            HStack {
               Text("Nicotine")
               Spacer()
               Text("\(String(format: "%.2f", viewModel.nicotineResult))ml")
            }
            HStack {
               Text("PG")
               Spacer()
               Text("\(String(format: "%.2f", viewModel.pgResult))ml")
            }
            HStack {
               Text("VG")
               Spacer()
               Text("\(String(format: "%.2f", viewModel.vgResult))ml")
            }
            ForEach(viewModel.juice.flavors.sorted(by: >), id: \.key) { key, value in
               HStack {
                Image(systemName: "drop.fill")
                Text("\(key)")
                    .lineLimit(1)
                Spacer()
                Text("\(String(format: "%.2f", ((Double(value) ?? 0)/100*viewModel.size)))ml")
                    .lineLimit(1)
              }
            }
         }
         .modifier(TextModifier(size: 16, weight: .regular))
         .padding()
         .frame(maxWidth: .infinity)
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
}


struct RecipeScreenView_Previews: PreviewProvider {
   static var previews: some View {
      RecipeScreenView(viewModel: RecipeScreenViewModel(juice: flavorsData[0], isEditable: true))
   }
}
