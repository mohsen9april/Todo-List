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
    @State private var animationButton: Bool = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    //MARK:- Body
    var body: some View {
        
        NavigationView{
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack{
                            Text(todo.name ?? "Unknown")
                            Spacer()
                            Text(todo.priority ?? "Unknown")
                        }
                    }.onDelete(perform: deleteTodo)
                }//: List
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(leading: EditButton(),trailing: Button(action: {
                    //Action
                    self.showingAddTodoView.toggle()
                }, label: {
                    Image(systemName: "plus")
                }))//: Add Button
                    .sheet(isPresented: $showingAddTodoView) {
                        AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
                
                //MARK:- NO TODO ITEMS
                if todos.count == 0 {
                    EmptyListView()
                }
            } // End ZStack
                .sheet(isPresented: $showingAddTodoView) {
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            }.overlay(
                ZStack {
                    
                    Group{
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animationButton ? 0.2 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                            .scaleEffect(self.animationButton ? 1 : 0)
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animationButton ? 0.15 : 0)
                            .scaleEffect(self.animationButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }.animation(Animation.easeOut(duration: 2).repeatForever(autoreverses: true))
                    
                    Button(action: {
                        //Action
                        self.showingAddTodoView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    })//: BUTTON
                        .onAppear(perform: {
                            self.animationButton.toggle()
                        })
                }//: ZStack
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                ,alignment: .bottomTrailing
            )
        }//: Navigation
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
