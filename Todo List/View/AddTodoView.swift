//
//  AddTodoView.swift
//  Todo List
//
//  Created by Mohsen Abdollahi on 9/18/20.
//  Copyright © 2020 Mohsen Abdollahi. All rights reserved.
//

import SwiftUI
import CoreData

struct AddTodoView: View {
    
    //MARK:- Properties
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    let priorities = ["Heigh", "Normal", "Low"]
    
    //MARK:- Body
    var body: some View {
        NavigationView{
            
            VStack{
                VStack(alignment: .leading, spacing: 20){
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))
                        
                    Picker(selection: $priority, label: Text("Priority")) {
                        ForEach(priorities,id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        
                        if self.name != "" {
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do{
                                try self.managedObjectContext.save()
                                  //print("New todo: \(todo.name ?? ""), priority: \(todo.priority ?? "")")
                            }catch{
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name!"
                            self.errorMessage = "Make sure to enter something for \n the new todo item."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                    }
                }//: VStack
                    .padding(.horizontal)
                    .padding(.vertical, 30)
                Spacer()
            }
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                //Action
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
                
                .alert(isPresented: $errorShowing) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

//MARK:- Preview
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
