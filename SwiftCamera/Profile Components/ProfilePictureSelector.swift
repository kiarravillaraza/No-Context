//
//  ProfilePictureSelector.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/28/22.
//
/*
 File that creates the image picker view that allows user to select a profile picture from their camera roll
 */

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    //used to retrieve selected photo
    @Binding var selectedPhoto: UIImage?
    
    //used to dismiss the image picker
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        let parent: ImagePicker
        
        init(_ parent: ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let image = info[.originalImage] as? UIImage else { return }
            parent.selectedPhoto = image
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        
    }
}
