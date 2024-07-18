//
//  NetworkService.swift
//  sciflarePro
//
//  Created by Briston on 18/07/24.
//

import Foundation
import SwiftyJSON
import CoreData
class NetworkService {
    @Published var items: [Item] = []
    
    func fetchItem() {
            
           let request: NSFetchRequest<Item> = Item.fetchRequest()
           do {
               self.items = try PersistenceController.shared.container.viewContext.fetch(request)
           } catch {
               print("Error fetching items: \(error)")
           }
       }
    
    func fetchData(completion: @escaping (JSON?, Error?) -> Void) {
        guard let url = URL(string: "https://crudcrud.com/api/58a080d6d53c493dbedddf5d62676e58/johsn") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                
                let json = JSON(data)
                
                completion(json, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func postData(itemDictionary: [String:Any], completion: @escaping (Error?) -> Void) {
           guard let url = URL(string: "https://crudcrud.com/api/58a080d6d53c493dbedddf5d62676e58/johsn") else {
               completion(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
           do {
               request.httpBody = try JSONSerialization.data(withJSONObject: itemDictionary, options: [])
           } catch {
               completion(error)
               return
           }
           
           URLSession.shared.dataTask(with: request) { (data, response, error) in
               guard let _ = data else {
                   completion(error)
                   return
               }
               let json = JSON(data)
               print(json)
               completion(nil)
           }.resume()
       }
}
