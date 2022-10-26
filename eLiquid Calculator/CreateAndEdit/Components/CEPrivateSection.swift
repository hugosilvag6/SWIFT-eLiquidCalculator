//
//  CEPrivateSection.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 12/09/22.
//

import SwiftUI

struct CEPrivateSection: View {
   
   @Binding var isPrivate: Bool
   
    var body: some View {
       Toggle(isOn: $isPrivate) {
          Text("Private Recipe")
             .modifier(TextModifier(size: 20))
       }
       .padding(.vertical, 10)
    }
}

struct CEPrivateSection_Previews: PreviewProvider {
    static var previews: some View {
       CEPrivateSection(isPrivate: .constant(true))
    }
}
