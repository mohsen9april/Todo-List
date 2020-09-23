//
//  EmptyListView.swift
//  Todo List
//
//  Created by Mohsen Abdollahi on 9/23/20.
//  Copyright © 2020 Mohsen Abdollahi. All rights reserved.
//

import SwiftUI

struct EmptyListView: View {
    //MARK:- PROPERTIES
    
    @State private var isAnimated: Bool = false
    
    //MARK:- BODY
    var body: some View {
        ZStack {
            VStack {
                Image("illustration-no1").resizable().scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                .layoutPriority(1)
                
                Text("Use your time wisely !")
                    .layoutPriority(0.5)
                    .font(.system(.headline))
            } //: VStack
                .padding(.horizontal)
                .opacity(isAnimated ? 1 : 0)
                .offset(y: isAnimated ? 0 : -50)
                .animation(.easeOut(duration: 1.5))
                .onAppear(perform: {
                    self.isAnimated.toggle()
                })
            
            
        }//: ZStack
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color("ColorBase")).edgesIgnoringSafeArea(.all)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView().environment(\.colorScheme, .dark)
    }
}
