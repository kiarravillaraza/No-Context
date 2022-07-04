//
//  LoginView.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/22/22.
//
/*
 File that houses the login view
 */
import SwiftUI
import UserNotifications

struct LoginView: View {
   
    @State private var email = ""
    @State private var password = ""
    @State var toggleIsOn:Bool = false
    @EnvironmentObject var viewModel: Authentication
   
    var body: some View {
        NavigationView{
        //parent
        VStack{
            //header for login
            LoginHeader()
            
            //user will interact with this to log in with their email and passwords
            LoginForm()
            
            Spacer()

            //button that will take user to registration view
            NavigationLink{
                RegistrationView()
                    .navigationBarHidden(true)
            } label:{
                HStack{
                Text("Don't have an account?")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("Sign up!")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    }
                }
            .padding(.top, 270)
            
            Spacer()
            }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        }

    }
}

struct LoginHeader: View {
   
    @State private var email = ""
    @State private var password = ""
    @State var toggleIsOn:Bool = false
    @EnvironmentObject var viewModel: Authentication
   
    var body: some View {
        VStack(alignment: .trailing){
            HStack{
                Spacer()
            }
        
            Text("Let's get")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 54.0)
            
            Text("that recap!")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("No Context")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.top, 17.0)
        }
        .frame(height: 260)
        .padding(.trailing, 38.0)
        .background(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: .bottomLeft))
    }
}

struct LoginForm: View {
   
    @State private var email = ""
    @State private var password = ""
    @State var toggleIsOn:Bool = false
    @EnvironmentObject var viewModel: Authentication
   
    var body: some View {
        
        VStack(spacing: 40){
            //field where user will enter their email
            TextfieldView(imageName: "envelope", placeholderText: "Email", text: $email)
            
            //field where user will enter their password
            TextfieldView(imageName: "lock", placeholderText: "Password", isSecureField: true, text: $password)
            
            
        }
        .padding(.horizontal, 32)
        .padding(.top, 44)
        
        Spacer()
        /*
         button that will allow users to login if the email and password fields were entered correctly and match the data in Firebase
         */
        Button {
                
            /*
             method that allows users to login with their email and password
             */
            viewModel.login(withEmail: email, password: password)

            /*
             creates a notification request for user, this allows the user to receive their daily notifications
             */
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) { success, error in
                if success {
                    print("DEBUG: Notification requested successfully!")
                          } else if let error = error {
                        print(error.localizedDescription)
                    }
            }
        } label: {
            Text("Sign in")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 340, height: 50)
                .background(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
                .clipShape(Capsule())
                .padding(.top, 15)
        }
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
    }
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

