//
//  RegistrationView.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/22/22.
//
/*
 File that houses the registration view
 */
import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: Authentication

    var body: some View {
        VStack{
            
            /*link that will take users to the profile picture view where they will select their profile picture, users will be taken to this destination once their account has been registered and authenticated in Firebase
             */
            NavigationLink(destination: ProfilePictureView(), isActive: $viewModel.userAuthenticated, label: {})
            
            //header
            HeaderView(title1: "Get started.", title2: "Create your account.")
           
            //user will interact with this to create and register an account
           RegistrationForm()
            
            Spacer()
            
            //button that will take user to login view
            Button{
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                Text("Already have an account?")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("Sign in!")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 35)
        }
        .ignoresSafeArea()
    }
}

struct RegistrationForm: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: Authentication

    var body: some View {
        VStack(spacing: 40){
            //field where users will enter their email
            TextfieldView(imageName: "envelope", placeholderText: "Email", text: $email)
            
            //field where users will create a username
            TextfieldView(imageName: "person", placeholderText: "Username", text: $username)
            
            //field where users will enter their full name
            TextfieldView(imageName: "person", placeholderText: "Full Name", text: $fullname)
            
            //secured field where users will create a password
            TextfieldView(imageName: "lock", placeholderText: "Password",
                       isSecureField: true, text: $password)
    
        }
        .padding(32)
        .padding(.top, 30)
        
        /*
         button that will allow users to create and register an account if all fields were entered correctly, if so, the information will be added to Firebase
         */
        Button {
            viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
        } label: {
            Text("Sign Up")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
                .clipShape(Capsule())
                .padding(.top, 15.0)
        }
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
