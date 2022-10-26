//
//  ProfileImage.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.
//

import SwiftUI

struct ProfileImage: View {
   
   @State var showSheet: Bool = false
   
   var strokeColor: Color
   @Binding var image: UIImage
   @Binding var profileUrl: String
   
   
   var body: some View {
      Button {
         showSheet = true
      } label: {
         ZStack {
            Circle()
               .stroke(strokeColor, lineWidth: 2)
               .frame(width: 170, height: 170)
            Circle()
               .fill(Color("ThemeLight"))
               .frame(width: 170, height: 170)
            Group {
               if image.size.width > 0 {
                  Image(uiImage: image)
                     .resizable()
                     .scaledToFill()
                     .clipShape(Circle())
               } else if profileUrl.count > 0 {
                  AsyncImage(url: URL(string: profileUrl)) { image in
                     image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                  } placeholder: {
                     ProgressView()
                  }
               } else {
                  Image(systemName: "photo.circle.fill")
                     .resizable()
                     .scaledToFit()
                     .foregroundColor(strokeColor)
               }
            }
            .frame(width: 150, height: 150)
            .overlay (alignment: .bottomTrailing) {
                  Image(systemName: "pencil")
                     .foregroundColor(.white)
                     .background {
                        Color("GradientFirstColor")
                           .frame(width: 40, height: 40)
                           .cornerRadius(100)
                     }
                     .offset(x: -10, y: -10)
                     .shadow(color: .black, radius: 6, x: 0, y: 0)
            }
         }
      }
      .sheet(isPresented: $showSheet) {
         ImagePicker(selectedImage: $image)
      }
   }
}

struct ProfileImage_Previews: PreviewProvider {
   static var previews: some View {
      ZStack {
         LinearGradient(gradient: Gradient(colors: [Color("GradientFirstColor"), Color("GradientSecondColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
         ProfileImage(strokeColor: .white, image: .constant(UIImage()), profileUrl: .constant(""))
      }
   }
}
