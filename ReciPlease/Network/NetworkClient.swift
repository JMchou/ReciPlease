//
//  NetworkClient.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 10/4/20.
//

import Foundation

struct NetworkClient {
   
   let apiKey = "ad2af8d2ef7a483c8af21968c54bff74"
   static let shared = NetworkClient()
   
   private init() { }
   
   //MARK: - public methods
   
   func fetchRecipe(query: String, completion: @escaping (Results?, Error?) -> Void ) {
      let urlString = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&query=\(query)&number=6&sort=popularity&sortDirection=desc&minCalories=0"
      fetchData(urlString: urlString, completion: completion)
   }
   
   func fetchRandomRecipe(completion: @escaping (Results?, Error?) -> Void) {
      let urlString = "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&query=chicken&number=6&sort=popularity&sortDirection=desc&minCalories=0"
      fetchData(urlString: urlString, completion: completion)
   }
   
   
   //MARK: - generic fetch method
   private func fetchData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
      
      guard let url = URL(string: urlString) else { return }
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         if let error = error {
            completion(nil, error)
            return
         }
         
         guard let data = data else { return }
         //check resposne status codes
         
         let jsonDecoder = JSONDecoder()
         do {
            let decodedData = try jsonDecoder.decode(T.self, from: data)
            completion(decodedData, nil)
         } catch {
            completion(nil, error)
         }
      }.resume()
   }
}
