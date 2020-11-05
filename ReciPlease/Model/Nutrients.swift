//
//  Nutrients.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 11/1/20.
//

import Foundation

struct Nutrition: Decodable, Hashable {
   let nutrients: [Nutrients]
}

struct Nutrients: Decodable, Hashable {
   let title: String
   let amount: Double
   let unit: String
   
}
