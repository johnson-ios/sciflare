//
//  ItemFormView.swift
//  sciflarePro
//
//  Created by Briston on 18/07/24.
//

import SwiftUI

struct ItemFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ItemListViewModel
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var mobile: String = ""
    @State private var gender: String = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
            TextField("Mobile", text: $mobile)
            TextField("Gender", text: $gender)
            
            Button("Save") {
//                let newItem = Item()
//        
//                newItem.name = name
//                newItem.email = email
//                newItem.mobile = mobile
//                newItem.gender = gender
                
                let param: [String: Any] = [
                    "name": $name.wrappedValue,
                    "email": $email.wrappedValue,
                    "mobile": $mobile.wrappedValue,
                    "gender": $gender.wrappedValue
                    ]
                viewModel.addItem(param)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Add Item")
    }
}


//#Preview {
//  //  ItemFormView()
//}
