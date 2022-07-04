//
//  UploadGrid.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/30/22.
//
/*
 File that houses the functions to create a grid document in Firebase
 */

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI

struct GridService {
    
    //method used to create a grid document in the grids collection in Firebase
    func postGrid(grid: [UIImage]){
        //uses the uid to create a grid object for the current user
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        //fields for the document
        let data = ["uid": uid, "grid": grid, "timestamp" : Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("grids")
            .document(uid)
            .setData(data) { _ in
                print("DEBUG: Grid was created successfully!")
                print("DEBUG: Grid id: \(uid)")

            }
    }
    
}
