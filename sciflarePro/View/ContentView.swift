//
//  ContentView.swift
//  sciflarePro
//
//  Created by Briston on 18/07/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ItemListViewModel
    
    var body: some View {
        
        NavigationView {
       
                VStack {
                    ItemListView(viewModel: viewModel)
                        .navigationBarTitle("Items")
                        
                    NavigationLink(destination: ItemFormView(viewModel: viewModel)) {
                        Text("Add Item")
                    }
                }
            
        
        }
    }
}

//#Preview {
//    let viewmodel = ItemListViewModel()
//            ContentView(viewModel: viewmodel)
//        
//}
