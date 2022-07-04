//
//  ProfilePictureView.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/28/22.
//
/*
 File that houses the profile picture view
 */
import SwiftUI

struct ProfilePictureView: View {
    @State private var showImagePicker = false
    @State private var selectedPicture: UIImage?
    @State private var profilePicture: Image?
    @EnvironmentObject var viewModel: Authentication
    
    var body: some View {
        VStack{
            //header
            HeaderView(title1: "One more thing.", title2: "Add a profile picture")
            
            //button that allows user to select a profile picture using a photo picker 
            Button {
                showImagePicker.toggle()
            } label : {
                
                //displays profile picture in view once it has been selected and uploaded to Firebase
                if let profilePicture = profilePicture {
                    profilePicture
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipShape(Rectangle())
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 0)
                } else {
                VStack{
                Image(systemName: "face.smiling")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 170)
                    .foregroundColor(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
                Text("Choose your photo")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
                    
                }
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 0)
                }
            }
            .padding(.top, 100.0)
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) { ImagePicker(selectedPhoto: $selectedPicture)
            }
            
            if let selectedPicture = selectedPicture {
                Button {
                    //button that uploads selected photo to Firebase
                    viewModel.uploadProfileImage(selectedPicture)
                    print("DEBUG: Profile picture addded, user has finished registering!")
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
                        .clipShape(Capsule())
                        .padding(.top, 15.0)
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedPicture = selectedPicture else { return }
        //constructs swift ui image from ui kit image
        profilePicture = Image(uiImage: selectedPicture)

    }
    
}

struct ProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePictureView()
    }
}
