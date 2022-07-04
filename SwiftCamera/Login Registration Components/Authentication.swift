//
//  Authentication.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/22/22.
//
/*
 File that houses all of the methods and properties needed for authentication for login and registration
 */
import Foundation
import SwiftUI
import Firebase

class Authentication: ObservableObject {
    
    //actual user session to take us to interface
    @Published var userSession: FirebaseAuth.User?
    
    /*
     if variable has a value, show main interface and load their user data
     if variable has no value, show authentication flow and login/sign up
    */
     @Published var userAuthenticated = false
    
    //temporary user session to choose and upload profile picture
    private var tempUserSession: FirebaseAuth.User?
    
    //variable to hold current user
    @Published var currentUser: User?
    
    //allows us to use methods from UserService
    private let service = UserService()
    
    init() {
        //if curent user is logged in, current user session is stored inside this variable
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
        print("DEBUG: User session is \(self.userSession?.uid)")
    }
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
            print("DEBUG: Failed to sign in. \(error.localizedDescription)")
            return
            }
            
            guard let user = result?.user else {return}
            self.userSession = user
            self.fetchUser()
            print("DEBUG: User was logged in successfully! User: \(self.userSession)")
            
            
        }
        
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register. \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else {return}
            self.tempUserSession = user

            print("DEBUG: User is \(self.tempUserSession)")
            
            //fields for the document
            let data = ["email": email,
                      "username": username.lowercased(),
                      "fullname": fullname,
                      "uid": user.uid]
            
            //creates a collection in firestore with the data from above
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.userAuthenticated = true
                    print("DEBUG: User was registered successfully!")
                }
            
            
        }
        
    }
    
    func signOut(){
        //shows login after setting user session to nil
        userSession = nil
         
        //signs user out on server
        try? Auth.auth().signOut()
        print("DEBUG: User was logged out successfully!")
    }
    
    /*
     method that uploads user's profile picture to firebase
     */
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ProfilePictureUploader.uploadProfile(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()

                }
        }
        
    }
    
    func gridPhotoUploader2(_ images: [UIImage]) {

        guard let uid = Auth.auth().currentUser?.uid else { return }

            GridPhotoUploader.uploadGridPhotos(images: images) { gridPhotoImageUrl in
                Firestore.firestore().collection("grids")
                    .document(uid)
                    .updateData(["grid": gridPhotoImageUrl]) { _ in
                        print("DEBUG: Grid updated")
                        print("\(uid)")

                    }
                
            }
    }
    
    /*
     method that fetches the current user's data from Firebase to update properties in the profile view
     */
    func fetchUser() {
        //uses the current user's uid to find their data
        guard let uid = self.userSession?.uid else { return }
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
        
}
    

