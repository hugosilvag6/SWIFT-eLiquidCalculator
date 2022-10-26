//
//  RecipeCalculatorView.swift
//  eLiquid Recipes
//
//  Created by Hugo Silva on 26/08/22.
//

import SwiftUI

struct RecipeCalculatorView: View {
  
  @ObservedObject var viewModel: RecipeCalculatorViewModel
  
  var body: some View {
    VStack {
      Form {
        // SPECIFICATIONS
        Section  {
          // NICOTINE STRENGTH
          HStack {
            Text("Nicotine strength")
            Spacer()
            TextField("Nicotine strength", text: $viewModel.nicotineStrengthInput)
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.trailing)
          }
          // SIZE
          HStack {
            Text("Size")
            Spacer()
            TextField("Size", text: $viewModel.sizeInput)
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.trailing)
          }
          // DESIRED STRENGTH
          HStack {
            Text("Desired strength")
            Spacer()
            TextField("Desired strength", text: $viewModel.desiredStrengthInput)
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.trailing)
          }
          // VG/PG
          HStack {
            Text("PG")
            Spacer()
            TextField("PG", text: $viewModel.pgInput)
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.trailing)
          }
        } header: {
          Text("Specifications")
        }

        
        // RESULT
        Section {
          HStack {
            Text("Nicotine")
            Spacer()
            Text(String(format: "%.2f", viewModel.nicotineResult))
          }
          HStack {
            Text("PG")
            Spacer()
            Text(String(format: "%.2f", viewModel.pgResult))
          }
          HStack {
            Text("VG")
            Spacer()
            Text(String(format: "%.2f", viewModel.vgResult))
          }
          ForEach(viewModel.flavor.flavors.sorted(by: >), id: \.key) { key, value in
            HStack {
              Image(systemName: "drop.fill")
              Text("\(key)")
              Spacer()
              Text("\(String(format: "%.2f", ((Double(value) ?? 0)/100*viewModel.size)))")
            }
          }
        } header: {
          Text("Result")
        }
      }
    }
    .navigationTitle(Text(viewModel.flavor.name))
    .navigationBarTitleDisplayMode(.inline)
  }
}


struct RecipeCalculatorView_Previews: PreviewProvider {
  static var previews: some View {
//    RecipeCalculatorView(flavor: flavorsData[0])
//    RecipeCalculatorView(viewModel: RecipeCalculatorViewModel())
    RecipeCalculatorView(viewModel: RecipeCalculatorViewModel(flavor: flavorsData[0]))
  }
}
