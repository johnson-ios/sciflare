//
//  ItemListView.swift
//  sciflarePro
//
//  Created by Briston on 18/07/24.
//

import SwiftUI

struct ItemListView: View {
    @ObservedObject var viewModel: ItemListViewModel
    
    var body: some View {
        
        NavigationStack {
            if viewModel.isLoading {
                           ProgressView("Loading...")
            }else{
                List {
                    ForEach(viewModel.itemsJson) { item in
                        VStack(alignment: .leading) {
                            Text(item.name ?? "")
                            Text(item.email ?? "")
                            Text(item.mobile ?? "")
                            Text(item.gender ?? "")
                        }
                        
                    }
                   
                }
            }
           
            
           
        }
        .onAppear {
            viewModel.fetchItemsFromCoreData()
        }
    }
    
    
    
}

//#Preview {
//    ItemListView()
//}
