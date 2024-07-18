//
//  sciflareProApp.swift
//  sciflarePro
//
//  Created by Briston on 18/07/24.
//

import SwiftUI

@main
struct sciflareProApp: App {
    let persistenceController = PersistenceController.shared
    let itemListViewModel = ItemListViewModel()  

    var body: some Scene {
        WindowGroup {
            
            
            
            ContentView(viewModel: itemListViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            // MapView()
            
            
            
        }
    }

}
