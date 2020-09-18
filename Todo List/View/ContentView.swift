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
    
    //MARK:- Body
    var body: some View {
        
        NavigationView{
            List(0..<5) { item in
                Text("New Item")
            }
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
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
}

//MARK:- Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
