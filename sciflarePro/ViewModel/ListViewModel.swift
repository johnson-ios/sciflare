//
//  ListViewModel.swift
//  sciflarePro
//
//  Created by Briston on 18/07/24.
//

import SwiftUI
import CoreData
import SwiftyJSON
class ItemListViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var itemsJson: [Item] = []
    private let networkService = NetworkService()
    
    func fetchItems() {
       
        networkService.fetchData { [weak self] (items, error) in
            guard let self = self else { return }
            
            if let items = items {
                DispatchQueue.main.async {
                    self.isLoading = true
                    let context = CoreDataStack.shared.persistentContainer.viewContext
                    
                     
                    self.itemsJson.removeAll()
                    
                    for indx in items.arrayValue {
                        let newItem = Item(context: context)
                        newItem.name = indx["name"].stringValue
                        newItem.email = indx["email"].stringValue
                        newItem.mobile = indx["mobile"].stringValue
                        newItem.gender = indx["gender"].stringValue
                        
                         
                        self.itemsJson.append(newItem)
                    }
                    
                    
                    self.saveItemsToCoreData(self.itemsJson)
                    self.isLoading = false
                }
            } else if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                self.isLoading = false
            }
            
        }
    }

    private func saveItemsToCoreData(_ items: [Item]) {
       
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        
        context.perform {
            do {
                
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                try context.execute(batchDeleteRequest)
                
                let olditems = try context.fetch(fetchRequest)
                for object in olditems {
                           guard let objectData = object as? NSManagedObject else {continue}
                    context.delete(objectData)
                       }
                
                for item in items {
                    
                    context.insert(item)
                }
                
                try context.save()
            } catch {
                print("Failed saving items to Core Data: \(error.localizedDescription)")
            }
           
        }
    }
     func fetchItemsFromCoreData() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        self.itemsJson.removeAll()
        do {
            let items = try context.fetch(fetchRequest)
            
           
            for item in items {
                let newItem = Item(context: context)
                newItem.name = item.name
                newItem.email = item.email
                newItem.mobile = item.mobile
                newItem.gender = item.gender
                
                
                self.itemsJson.append(newItem)
            }
            
        } catch {
            print("Failed to fetch items from Core Data: \(error.localizedDescription)")
        }
       
    }
    
    func addItem(_ item:  [String:Any]) {
       
        isLoading = false
        
        networkService.postData(itemDictionary: item) { [weak self] error in
            if let error = error {
                print("Error adding item: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    
                    self?.fetchItems()
                }
            }
        }
    }
}
