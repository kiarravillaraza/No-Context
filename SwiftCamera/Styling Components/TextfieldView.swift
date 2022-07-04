//
//  TextfieldView.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/22/22.
//
/*
 File that houses the textfield components for the login and registration forms
 */
import SwiftUI

struct TextfieldView: View {
    
    let imageName: String
    let placeholderText: String
    var isSecureField: Bool? = false
    @Binding var text: String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                
                if isSecureField ?? false {
                    
                    SecureField(placeholderText, text: $text)

                } else {
                    
                    TextField(placeholderText, text: $text)
                    
                }
            }
            
            Divider()
                .background(Color(#colorLiteral(red: 0.8147885799, green: 0.8147885799, blue: 0.8147885799, alpha: 1)))
        }
    }
}

struct TextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextfieldView(imageName: "envelope",
                   placeholderText: "Email",
                   isSecureField: false,
                   text: .constant(""))
    }
}
