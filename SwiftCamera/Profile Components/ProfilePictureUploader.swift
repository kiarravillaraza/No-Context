//
//  ProfilePictureUploader.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/30/22.
//
/*
 File to upload images to Firestore
 */

import Firebase
import UIKit
import FirebaseStorage

struct ProfilePictureUploader {
    //upload an image and return location of image with url
    static func uploadProfile(image: UIImage, completion: @escaping(String) -> Void) {
        
        //lowers quality of image but reduces image size to make the downloaded file smaller to make app faster and limit data usage
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        
        //creates a path for the image in storage
        let ref = Storage.storage().reference(withPath: "/profile_picture/\(filename)")
        
        //uploading data
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image. Error: \(error.localizedDescription)")
                return
            }
            
        //url for image 
            ref.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else { return }
                completion(imageUrl)
            
            }
            
        }
        
    }
    
    
    
}
