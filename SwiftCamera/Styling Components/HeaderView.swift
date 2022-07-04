//
//  HeaderView.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/22/22.
//
/*
 File that houses the header components used for styling header, used in registration and profile picture view
 */
import SwiftUI

struct HeaderView: View {
    
    let title1: String
    let title2: String
    
    var body: some View {
        VStack(alignment: .trailing){
            HStack{
                Spacer()
            }
                
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
        
        }
        .frame(height: 260)
        .padding(.trailing, 25.0)
        .background(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: .bottomLeft))
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title1: "Get started.", title2: "Create your account.")
    }
}
