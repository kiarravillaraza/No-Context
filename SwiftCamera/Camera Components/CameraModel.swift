//
//  CameraModel.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/22/22.
//

/*
 File that houses all of the functions and properties of the camera feature
 */
import Foundation
import AVFoundation
import SwiftUI
import Firebase

public struct Grid: Identifiable {
    //creates a grid item once the array is full
        public var id: String
       public var grid: [UIImage]

       public init(id: String = UUID().uuidString, grid: [UIImage]) {
           self.id = id
           self.grid = grid
       }
}

class CameraModel: NSObject, AVCapturePhotoCaptureDelegate, ObservableObject{
    
    @Published var isTaken = false
        
    //capture session for camera
    @Published var session = AVCaptureSession()
    
    
    // Used to read picture data
    @Published var output = AVCapturePhotoOutput()
    
    // camera preview
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    @Published var isSaved = false
        
    // Picture data
    @Published var pictureData = Data(count: 0)
    
    //array of captured pictures
    @Published var collection = [UIImage]()
          
    //grid object where collection array will be saved
    @Published var finalGrid: Grid?
    
    
    func CheckPermissions(){
        
        // Checking to see if camera has permission ...
        switch AVCaptureDevice.authorizationStatus(for: .video) {
       
        case .authorized:
           
            // Setting up session
            SetUp()
            return
           
            
        case .notDetermined:
           
            // Retesting for permission
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status{
                    self.SetUp()
                }
            }
        
        case .denied:
            return
            
        default:
            return
            
        }
    }
    
    func SetUp(){
        
        // Setting up camera
        
        do {
            
            // setting configurations
            self.session.beginConfiguration()
           
            var device: AVCaptureDevice?


            if let backCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                // If a rear dual camera is not available, default to the rear wide angle camera.
                device = backCameraDevice
            } else if let frontCameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                // If the rear wide angle camera isn't available, default to the front wide angle camera.
                device = frontCameraDevice
            }
                        
            let input = try AVCaptureDeviceInput(device: device!)
            
            // checking and adding to session
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            // same for output
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    /*
     method that allows user to take pictures with the camera
     */
    func TakePicture(){
        //takes picture
        DispatchQueue.global(qos: .background).async {
            
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            //self.session.stopRunning()

            DispatchQueue.main.async {
                
                withAnimation{self.isTaken.toggle()}
                print("Picture was taken!")

            }
        }
    }
    
    /*
     method that allows user to retake pictures with the camera
     */
    func Retake(){
        
        DispatchQueue.global(qos: .background).async {
            
            self.session.startRunning()
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
                // clearing last snapped picture
                self.isSaved = false
            }
        }
        print("Retake in progress")
    }
    
    
    /*
     method to save photo data
     */
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            return
        }
        print("Picture was taken!")
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.pictureData = imageData
    }
    
    /*
     method that saves captured photo to user's camera roll and adds captured photo to the collection array
     */
    func SavePicture() {
        
        let image = UIImage(data: self.pictureData)!
         //saving picture to photo album
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        print("DEBUG: Picture saved to camera roll successfully!")
        
        self.isTaken = true
        
        //stops adding pictures to collection array after 4 pictures are captured
        if collection.count != 4 {
        AddPicture()
        print("Debug: Picture was added to collection successfully!")
        }
        print("DEBUG: Printing contents of collection:")
        print(collection)

   
        
        //capture session stops running once array has been filled
        if collection.count == 4 {
    
        //once collection array has 4 images, a grid object is created with the collection array
        createGrid()
        
        print("Debug: Getting ready to delete collection!")
        //deletes contents from collection to restart index to 0 for next grid
        collection.removeAll()
        print("Debug: Collection deleted successfully!")

        self.session.stopRunning()
            
        }
    }
        
    /*
        method that adds captured picture to collection array
     */
    func AddPicture() {
        //adds captured picture to array
        let image = UIImage(data: self.pictureData)!
        collection.append(image)
        self.isSaved = true
    }
    

    /*
     method that creates a grid object once the user has captured and saved 4 pictures and the collection array has been filled
     */
    func createGrid(){
        finalGrid = Grid(grid: collection)
        //test to make sure that a grid object has been created
        print("DEBUG: Final grid id: \(finalGrid?.id as Any)")
        


    }
    
}
