//
//  User.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 7/2/22.
//
/*
 File that maps the data from the users collection in Firebase to be used in the profile view
 */
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    
    //fields in the user document
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
}
