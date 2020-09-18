//
//  AddTodoView.swift
//  Todo List
//
//  Created by Mohsen Abdollahi on 9/18/20.
//  Copyright © 2020 Mohsen Abdollahi. All rights reserved.
//

import SwiftUI

struct AddTodoView: View {
    
    //MARK:- Properties
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    @Environment(\.presentationMode) var presentationMode
    
    let priorities = ["Heigh", "Normal", "Low"]
    
    //MARK:- Body
    var body: some View {
        NavigationView{
            
            VStack{
                Form{
                    TextField("Prioriry", text: $name)
                    Picker(selection: $priority, label: Text("Priority")) {
                        ForEach(priorities,id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        //Action
                        print("Svae a new todo !")
                    }) {
                        Text("Save")
                    }
                }
                Spacer()
            }
            .navigationBarTitle("New Todo", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            //Action
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
        }))
        }
    }
}

//MARK:- Preview
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
