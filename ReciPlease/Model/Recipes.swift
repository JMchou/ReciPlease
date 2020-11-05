//
//  Recipes.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 11/1/20.
//

import Foundation

struct Recipes: Hashable, Decodable {
   let id: Int
   let title: String
   let image: String
   let nutrition: Nutrition
}

