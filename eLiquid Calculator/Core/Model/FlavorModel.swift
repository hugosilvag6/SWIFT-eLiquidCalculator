//
//  FlavorModel.swift
//  eLiquid Recipes
//
//  Created by Hugo Silva on 26/08/22.
//

import Foundation

enum FlavorType: String, CaseIterable {
   case dessert = "Dessert"
   case minty = "Minty"
   case fruity = "Fruity"
   case tobacco = "Tobacco"
   
   var id: String { return self.rawValue }
}

struct Juice: Identifiable {
   var id = UUID().uuidString
   var type: String
   var name: String
   var description: String
   var nicotineStrength: String
   var size: String
   var desiredStrength: String
   var pg: String
   var flavors: [String:String]
   var author: String
   var creationDate: String
   var isPrivate: Bool
}

let flavorsData: [Juice] = [
   Juice(type: "Dessert",
         name: "Vanilla Cupcake",
         description: "This is a dessert juice inspired by Vanilla Cupcakes.",
         nicotineStrength: "250",
         size: "30",
         desiredStrength: "40",
         pg: "50",
         flavors: ["Cheesecake Graham Crust" : "2", "Vanilla Cupcake" : "5"],
         author: "Hugo Garcia",
        creationDate: "1 Jan 2001",
        isPrivate: false)
]
