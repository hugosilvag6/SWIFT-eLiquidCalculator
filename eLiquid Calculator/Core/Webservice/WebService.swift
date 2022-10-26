//
//  WebService.swift
//  eLiquid Calculator
//
//  Created by Hugo Silva on 02/09/22.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseStorage

enum Result {
   case error(String)
   case success(String)
}
enum FetchRecipesResult {
   case error(String)
   case success([Juice])
}

class WebService {
   
   public static func deleteImage(path: String, completion: @escaping (Result) -> Void) async {
      
      guard let filename = Auth.auth().currentUser?.uid else {
         completion(.error("Failed to create profile image name. User is not authenticated."))
         return
      }
      
      // Firebase Storage reference
      let ref = Storage.storage().reference(withPath: "/\(path)")
      
      // Delete old picture
      let oldRef = ref.child("\(filename).jpg")
      oldRef.delete { error in
         if let error = error {
            completion(.error(error.localizedDescription))
            return
         } else {
            completion(.success("Image successfully deleted."))
         }
      }
   }
   
   
   public static func uploadImage(path: String, image: UIImage, completion: @escaping (Result) -> Void) async {
      
      guard let filename = Auth.auth().currentUser?.uid else {
         completion(.error("Failed to create profile image name. User is not authenticated."))
         return
      }
      
      // Compress the image
      guard let data = image.jpegData(compressionQuality: 0.2) else {
         print("Failed to create binary data object from image.")
         return
      }
      // Set picture format
      let newMetadata = StorageMetadata()
      newMetadata.contentType = "image/jpeg"
      // Firebase Storage reference
      let ref = Storage.storage().reference(withPath: "/\(path)/\(filename).jpg")
      // Send the picture
      ref.putData(data, metadata: newMetadata) { metadata, error in
         if let error = error {
            completion(.error(error.localizedDescription))
            return
         }
         // Getting download URL
         ref.downloadURL { url, error in
            if let error = error {
               completion(.error(error.localizedDescription))
               return
            }
            guard let url = url else {
               print("Failed to get picture URL.")
               return
            }
            completion(.success(url.absoluteString))
         }
      }
   }
   
   
   public static func updateUser (profile: Profile, completion: @escaping (Result) -> Void) async {
      
      guard let id = Auth.auth().currentUser?.uid else {
         completion(.error("User is not authenticated."))
         return
      }
      
      Firestore.firestore().collection("users")
         .document(id)
         .setData(["name": profile.name,
                   "uuid": id,
                   "profileUrl": profile.profileUrl,
                   "joined": profile.joinDate,
                   "phone": profile.phone])
      { error in
         if error != nil {
            completion(.error(error!.localizedDescription))
            return
         } else {
            completion(.success("Profile updated."))
         }
      }
      let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
      changeRequest?.displayName = profile.name
      changeRequest?.commitChanges { error in
         if let error = error {
            completion(.error(error.localizedDescription))
         }
      }

   }
   
   
   public static func createOrUpdateJuice (juice: Juice, completion: @escaping (Result) -> Void) {

      
      guard let id = Auth.auth().currentUser?.uid else {
         completion(.error("User is not authenticated."))
         return
      }
      guard let author = Auth.auth().currentUser?.displayName else {
         completion(.error("Failed to fetch user name."))
         return
      }
      let privateRef = Firestore.firestore()
         .collection("privateJuices")
         .document(id)
         .collection("userJuices")
         .document(juice.id)
      let publicRef = Firestore.firestore()
         .collection("publicJuices")
         .document(juice.id)
      
      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "en_US_POSIX")
      formatter.dateFormat = "d MMM y"
      let creationDate = formatter.string(from: Date.now)
      
      privateRef.setData(["type": juice.type,
                          "name": juice.name,
                          "description": juice.description,
                          "nicotineStrength": juice.nicotineStrength,
                          "size": juice.size,
                          "desiredStrength": juice.desiredStrength,
                          "pg": juice.pg,
                          "flavors": juice.flavors,
                          "author": author,
                          "creationDate": creationDate,
                          "isPrivate": juice.isPrivate])
      { error in
         if error != nil {
            completion(.error(error!.localizedDescription))
            return
         } else {
            completion(.success("Juice created."))
         }
      }
      
      if !juice.isPrivate {
         publicRef.setData(["type": juice.type,
                             "name": juice.name,
                            "description": juice.description,
                             "nicotineStrength": juice.nicotineStrength,
                             "size": juice.size,
                             "desiredStrength": juice.desiredStrength,
                             "pg": juice.pg,
                             "flavors": juice.flavors,
                             "author": author,
                            "creationDate": creationDate,
                            "isPrivate": juice.isPrivate])
         { error in
            if error != nil {
               print(error!.localizedDescription)
               return
            } else {
               print("Juice created.")
            }
         }
      }
      
   }
   
   
   public static func makeJuicePrivate (juiceId: String) {
      
      guard (Auth.auth().currentUser?.uid) != nil else {
         print("User is not authenticated.")
         return
      }
      
      let publicRef = Firestore.firestore()
         .collection("publicJuices")
         .document(juiceId)
      
      publicRef.delete() { error in
          if let error = error {
              print("Error removing document: \(error)")
          }
      }
      
   }
   
   
   public static func fetchRecipes (isPublic: Bool, completion: @escaping (FetchRecipesResult) -> Void) {
      
      guard let id = Auth.auth().currentUser?.uid else {
         completion(.error("User is not authenticated."))
         return
      }
      
      let ref: CollectionReference
      
      if isPublic {
         ref = Firestore.firestore()
            .collection("publicJuices")
      } else {
         ref = Firestore.firestore()
            .collection("privateJuices")
            .document(id)
            .collection("userJuices")
      }

      
      ref.getDocuments { querySnapshot, error in
         
         if let error = error {
            completion(.error(error.localizedDescription))
            return
         }
         
         if let documents = querySnapshot?.documents {
            var recipes = [Juice]()
            for document in documents {
               
               recipes.append(Juice(id: document.documentID,
                                    type: document.data()["type"] as? String ?? "",
                                    name: document.data()["name"] as? String ?? "",
                                    description: document.data()["description"] as? String ?? "",
                                    nicotineStrength: document.data()["nicotineStrength"] as? String ?? "",
                                    size: document.data()["size"] as? String ?? "",
                                    desiredStrength: document.data()["desiredStrength"] as? String ?? "",
                                    pg: document.data()["pg"] as? String ?? "",
                                    flavors: document.data()["flavors"] as? [String:String] ?? [:],
                                    author: document.data()["author"] as? String ?? "Unknown",
                                    creationDate: document.data()["creationDate"] as? String ?? "",
                                    isPrivate: document.data()["isPrivate"] as? Bool ?? true))
            }
            completion(.success(recipes))
         }
      }
   }
   
   
   public static func numberOfUsers (completion: @escaping (Int) -> Void) {
      Firestore.firestore().collection("users")
         .getDocuments { querySnapshot, error in
            if let error = error {
               print(error.localizedDescription)
               completion(0)
            }
            if let querySnapshot = querySnapshot {
               completion(querySnapshot.count)
            }
         }
   }
}
