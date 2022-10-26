//
//  AuthenticationViewModel.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 30/08/22.
//

import SwiftUI
import Firebase
import FirebaseStorage

class AuthenticationViewModel: ObservableObject {
   
   @Published var uiState: AuthenticationUIState = .none
   
   @Published var email: String = ""
   @Published var password: String = ""
   @Published var name: String = ""
   @Published var profileImage = UIImage()
   @Published var isSignIn: Bool = false
   
   func registerValidation () {
      if profileImage.size.width < 1 {
         self.uiState = .error("Choose a picture.")
      } else if !email.isEmail() {
         self.uiState = .error("Invalid email.")
      } else if !name.contains(" ") || name.count < 4 {
         self.uiState = .error("Full name required.")
      } else if password.count < 6 {
         self.uiState = .error("Password must have at least 6 characters.")
      } else {
         print("Valid user. Starting user creation...")
         self.uiState = .loading
         self.authRegister()
      }
   }
   
   private func authRegister () {
      Auth.auth().createUser(withEmail: email, password: password) { result, error in
         guard let user = result?.user, error == nil else {
            self.uiState = .error(error!.localizedDescription)
            return
         }
         print("FirebaseAuth user successfully created. Starting name update...")
         self.authDisplayNameUpdate()
      }
   }
   
   private func authDisplayNameUpdate () {
      let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
      changeRequest?.displayName = self.name
      changeRequest?.commitChanges { error in
         if let error = error {
            self.uiState = .error(error.localizedDescription)
            return
         }
         print("User name successfully updated. Starting photo upload...")
         self.storagePictureUpload()
      }
   }
   
   private func storagePictureUpload () {
      guard let filename = Auth.auth().currentUser?.uid else {
         self.uiState = .error("Failed to create profile image name. User is not authenticated.")
         return
      }
      guard let data = self.profileImage.jpegData(compressionQuality: 0.2) else {
         print("Failed to create binary data object from image.")
         return
      }
      // Setting picture format
      let newMetadata = StorageMetadata()
      newMetadata.contentType = "image/jpeg"
      // Firebase Storage reference
      let ref = Storage.storage().reference(withPath: "/profile-images/\(filename).jpg")
      
      // Send the picture
      ref.putData(data, metadata: newMetadata) { metadata, error in
         if let error = error {
            self.uiState = .error(error.localizedDescription)
            return
         }
         // Getting download URL
         ref.downloadURL { url, error in
            if let error = error {
               self.uiState = .error(error.localizedDescription)
               return
            }
            guard let url = url else {
               print("Failed to get picture URL.")
               return
            }
            print("User picture successfully uploaded. Url: \(url)")
            print("Starting Firestore user creation...")
            self.firestoreUser(photoUrl: url)
         }
      }
   }
   
   private func firestoreUser (photoUrl: URL) {
      guard let id = Auth.auth().currentUser?.uid else {
         self.uiState = .error("Failed to create Firestore document. User is not authenticated.")
         return
      }
      
      // Create register Date
      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "en_US_POSIX")
      formatter.dateFormat = "d MMM y"
      let joinDate = formatter.string(from: Date.now)
      
      Firestore.firestore().collection("users")
         .document(id)
         .setData([
            "name": self.name,
            "uuid": id,
            "profileUrl": photoUrl.absoluteString,
            "joined": joinDate
         ]) { error in
            if error != nil {
               print("Failed to create Firestore document.")
               print(error!.localizedDescription)
               return
            }
         }
      print("User successfuly created.")
      self.uiState = .success
   }
   
   func login () {
      self.uiState = .loading
      Auth.auth().signIn(withEmail: email, password: password) { result, error in
         if let error = error {
            self.uiState = .error(error.localizedDescription)
         }
         if let result = result {
            print(result.description)
            self.uiState = .success
         }
      }
   }
}
