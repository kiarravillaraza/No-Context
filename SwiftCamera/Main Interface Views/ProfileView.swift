//
//  ProfileView.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 7/2/22.
//
/*
File that houses the profile view
*/
import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: Authentication
    @ObservedObject var viewModel: ProfileViewModel

    init(user: User){
        self.viewModel = ProfileViewModel(user: user)
    }
    
    
    var body: some View {
        //sets user to current user to fetch their data from Firebase
        if let user = authViewModel.currentUser {
        
            VStack{
            ZStack{
                
                Rectangle()
                .frame(height: 300)
                    .foregroundColor(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
                
                VStack{
                    //profile picture
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 17))
                        .foregroundColor(.white)
                VStack{
                    //full name
                    Text(user.fullname)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                    //username
                    Text("@\(user.username)")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                .padding(.top, 15.0)
                }
                .padding(.top, 33.0)
                
            }
            .ignoresSafeArea()
            .padding(.bottom, 400)

            //button that allows users to log out and return to the sign in page
            Button {
                authViewModel.signOut()
            } label: {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
                    .clipShape(Capsule())
                    .padding(.bottom, 50)
                }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(id: NSUUID().uuidString, username: "kiarravillaraza", fullname: "Kiarra Villaraza", profileImageUrl: "", email: "kiarra1010@gmail.com"))
    }
}
