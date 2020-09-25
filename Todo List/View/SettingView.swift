//
//  SettingView.swift
//  Todo List
//
//  Created by Mohsen Abdollahi on 9/25/20.
//  Copyright © 2020 Mohsen Abdollahi. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    //MARK:- PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    //MARK:- BODY
    var body: some View {
        
        NavigationView{
            VStack{
                Form{
                    
                    //MARK:- SECTION3
                    Section(header: Text("Follow us on social media")){
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://www.apple.com")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://www.Twitter.com")
                        FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Website", link: "https://www.udemy.com")
                    }//:SECTION3
                        .padding(.vertical,3)
                    
                    //MARK:- SECTION4
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Aplication", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compability", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "John / Jane")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "imohsenui")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    }//:SECTION4
                        .padding(.vertical,3)
                }//:Form
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                
                //MARK:- FOOTER
                Text("CopyRight © All rights reserved.\nBetter App ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .padding(.top,6)
                    .padding(.bottom,8)
                    .foregroundColor(Color.secondary)
            }//:VStack
            .navigationBarItems(trailing: Button(action: {
                //Action
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
                .navigationBarTitle("Setting", displayMode: .inline)
                .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        }//:NavigationView
    }
}
//MARK:- PREVIEW
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
