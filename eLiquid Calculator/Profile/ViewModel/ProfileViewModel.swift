//
//  ProfileViewModel.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 01/09/22.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct Profile: Hashable, Equatable {
   var profileUrl: String
   var joinDate: String
   var name: String
   var email: String
   var phone: String
   var profileImage: UIImage
   
   public static func ==(lhs: Profile, rhs: Profile) -> Bool{
      return
      lhs.profileUrl == rhs.profileUrl &&
      lhs.joinDate == rhs.joinDate &&
      lhs.name == rhs.name &&
      lhs.email == rhs.email &&
      lhs.phone == rhs.phone &&
      lhs.profileImage == rhs.profileImage
   }
   
}

class ProfileViewModel: ObservableObject {
   
   @Published var uiState: ProfileUIState = .none
   
   @Published var didUpdate: Bool = false
   
   @Published var profileImage = UIImage()
   
   @Published var displayProfile = Profile(profileUrl: "", joinDate: "", name: "", email: "", phone: "", profileImage: UIImage())
   var fetchedProfile = Profile(profileUrl: "", joinDate: "", name: "", email: "", phone: "", profileImage: UIImage())
   
   @Published var profileUrllll = ""
   
   func fetchProfile() {
      
      
      self.uiState = .loading
      
      if let user = Auth.auth().currentUser {

         Firestore.firestore().collection("users").document(user.uid)
            .getDocument { document, error in
               if let document = document {
                  self.fetchedProfile.profileUrl = document.data()?["profileUrl"] as? String ?? ""
                  self.fetchedProfile.joinDate = document.data()?["joined"] as? String ?? ""
                  self.fetchedProfile.name = document.data()?["name"] as? String ?? ""
                  self.fetchedProfile.email = user.email ?? "error"
                  self.fetchedProfile.phone = document.data()?["phone"] as? String ?? ""
                  
                  self.displayProfile = self.fetchedProfile
                  
                  self.uiState = .none

               } else {
                  print("Document does not exist")
                  self.uiState = .error("Failed to fetch user.")
               }
            }
      }
   }
   
   func updateUser() async {
      
      self.uiState = .loading
      
      // If image changed:
      if self.displayProfile.profileImage != self.fetchedProfile.profileImage {
         
         // upload
         await WebService.uploadImage(path: "profile-images", image: self.displayProfile.profileImage, completion: { result in
            switch result {
            case .error(let msg):
               self.uiState = .error(msg)
            case .success(let msg):
               print("Image successfully uploaded.")
               self.displayProfile.profileUrl = msg
               print("displayProfile.profileUrl updated.")
            }
         })
         
      }
      
      // update profile
      await WebService.updateUser(profile: self.displayProfile, completion: { result in
         switch result {
         case .error(let msg):
            self.uiState = .error(msg)
         case .success(let msg):
            self.fetchedProfile = self.displayProfile
            self.uiState = .success(msg)
         }
      })
   }
    
}
