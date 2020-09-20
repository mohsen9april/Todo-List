//
//  ContentView.swift
//  Todo List
//
//  Created by Mohsen Abdollahi on 9/18/20.
//  Copyright © 2020 Mohsen Abdollahi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //MARK:- Properties
    @State private var showingAddTodoView: Bool = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    //MARK:- Body
    var body: some View {
        
        NavigationView{
            List {
                ForEach(self.todos, id: \.self) { todo in
                    HStack{
                        Text(todo.name ?? "Unknown")
                        Spacer()
                        Text(todo.priority ?? "Unknown")
                    }
                }.onDelete(perform: deleteTodo)
            }
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),trailing: Button(action: {
                //Action
                self.showingAddTodoView.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
                
                .sheet(isPresented: $showingAddTodoView) {
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }
    
    //MARK:- FUNCTIONS
    
    private func deleteTodo(at offset : IndexSet) {
        for index in offset {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
  
}

//MARK:- Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let contxt = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
        .environment(\.managedObjectContext, contxt)
    }
}
