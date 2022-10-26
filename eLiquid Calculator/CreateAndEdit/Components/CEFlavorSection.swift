//
//  FlavorSectionCreateEdit.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 12/09/22.
//

import SwiftUI

struct CEFlavorSection: View {
   
   @Binding var flavorList: [UniqueFlavor]
   
    var body: some View {
       VStack {
          ForEach($flavorList.indices, id: \.self) { index in
             VStack {
                HStack {
                   Button {
                      flavorList.remove(at: index)
                   } label: {
                      Image(systemName: "minus.circle.fill")
                         .foregroundColor(.red)
                         .font(.system(size: 25))
                   }
                   TextField("Insert name", text: $flavorList[index].name)
                      .modifier(TextModifier(size: 20, color: Color("GradientFirstColor")))
                      .disableAutocorrection(true)
                   TextField("Insert amount", text: $flavorList[index].amount)
                      .multilineTextAlignment(.trailing)
                      .modifier(TextModifier(size: 20))
                }
                .padding(.bottom, 7)
                Rectangle()
                   .fill(Color(white: 0.8))
                   .frame(height: 1)
             }
             .padding(.top)
          }
          
          
          Button {
             flavorList.append(UniqueFlavor(name: "", amount: ""))
          } label: {
             HStack {
                Text("Add flavor".uppercased())
                   .bold()
                   .foregroundColor(.black)
                   
                Image(systemName: "plus")
             }
             .padding()
             .background {
                RoundedRectangle(cornerRadius: 20)
                   .fill(Color(white: 0.95))
             }
          }
          .padding(.top)
       }
    }
}

struct CEFlavorSection_Previews: PreviewProvider {
    static var previews: some View {
       CEFlavorSection(flavorList: .constant([]))
    }
}
