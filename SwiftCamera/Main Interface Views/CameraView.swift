//
//  CameraView.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/22/22.
//
/*
 File that houses the camera view
 */
import SwiftUI
import AVFoundation

struct CameraView: View {
    
    //creates an environment object to allow all views to access the camera
    @EnvironmentObject var camera: CameraModel
    @EnvironmentObject var viewModel: Authentication


    var body: some View {
        ZStack{
            //Shows camera preview
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack{
               
                if camera.isTaken{
                    HStack {
                    
                    //button that allows user to retake picture once a picture has been taken
                        Button(action: camera.Retake, label: {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60, alignment: .center)
                                .overlay(
                                    Image(systemName: "arrow.left.arrow.right")
                                        .resizable()
                                        .frame(width: 28, height: 30, alignment: .center)
                                        .foregroundColor(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1))))
                        })
                        .padding(.leading, 275)                        
                    }
                }
                
                Spacer()
                
                HStack{
                    
                    //if picture has been taken, show save and retake button
                    
                    if camera.isTaken{
                        
                        //button that allows user to save picture
                        Button(action: { if !camera.isSaved{camera.SavePicture()}
                           
                        }, label: {
                                
                            Text(camera.isSaved ? "U S E D " : "U S E")
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .padding(.vertical, 15.0)
                                .padding(.horizontal, 20)
                                .background(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
                                .clipShape(Capsule())
    
                        })
                        .padding(.leading, 125)
                        
                        Spacer()
                        
                    } else {
                        
                        Button(action: camera.TakePicture, label: {
                                
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: 65, height: 65, alignment: .center)
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)), lineWidth: 6)
                                            .frame(width: 65, height: 65, alignment: .center)
                                    )
                        })
                    
                    }
                }
                .frame(height: 75)
            }
        }
        .onAppear {
            camera.CheckPermissions()
        }
    }
}

// setting view for preview
struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        // change accordingly
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        // starting session
        camera.session.startRunning()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
}

