//
//  ProfileViewModel.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 7/2/22.
//
/*
 File that houses the functions to create a grid document in Firebase
 */

import Foundation

class ProfileViewModel: ObservableObject {
    //private let service = GridService()
    let user: User
    
    init(user: User){
        self.user = user
    }
    
    
}
