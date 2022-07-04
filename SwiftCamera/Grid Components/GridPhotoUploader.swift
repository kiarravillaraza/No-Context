//
//  GridPhotoUploader.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 7/1/22.
//
/*
 File to upload images to Firestore
 */
import Firebase
import UIKit
import FirebaseStorage

struct GridPhotoUploader {
    //upload an image and return location of image with url

   /*
        method used to upload user's captured images to firebase and returns the location of the images with urls
    */
    static func uploadGridPhotos(images: [UIImage], completion: @escaping([String]) -> Void) {
        
        //returned array of image urls
        var postImagesUrl: [String] = []
        
        images.forEach { image in
            
            //lowers quality of image but reduces image size to make the downloaded file smaller to make app faster and limit data usage
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }

            let filename = NSUUID().uuidString

            //creates a path for the images in storage
            let ref = Storage.storage().reference(withPath: "/grids_picture/\(filename)")
            
            //uploading data
            ref.putData(imageData, metadata: nil) { metadata, error in
                if let error = error {
                    print("DEBUG: Failed to upload post image \(error.localizedDescription)")
                    return
                }
                
            //urls for images
                ref.downloadURL { url, error in
                    guard let imageUrl = url?.absoluteString else { return }
                    postImagesUrl.append(imageUrl)
                    completion(postImagesUrl)
                }
            }
        }
        print("DEBUG: Images were stored successfully!")

    }
}
