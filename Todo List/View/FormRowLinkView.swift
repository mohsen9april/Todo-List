//
//  FormRowLinkView.swift
//  Todo List
//
//  Created by Mohsen Abdollahi on 9/25/20.
//  Copyright © 2020 Mohsen Abdollahi. All rights reserved.
//

import SwiftUI

struct FormRowLinkView: View {
    //MARK:- ROPERTIES
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    //MARK:- BODY
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(Color.white)
            }//:ZStack
                .frame(width:36, height: 36)
            
            Text(text).foregroundColor(Color.gray)
            Spacer()
            Button(action: {
                //Open a Link
                guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
                
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }).accentColor(Color(.systemGray))
            
            
        }//: HStack
    }
}

//MARK:- PREVIEW
struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "www.google.com")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
        
    }
}
