//
//  ContentView.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/16/22.
//
/*
 file that houses the main interface view that allows users to navigate through the app using the tab bar 
 */

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @EnvironmentObject var viewModel: Authentication
    
    @StateObject var camera : CameraModel = CameraModel()
    
    @State private var selection =  1
    
    var body: some View {
        
        //no user logged in
        if viewModel.userSession == nil {
            LoginView()
        } else {
            //user logged in
        TabView{
            if let user = viewModel.currentUser {
        //tab to get users to their profile
            ProfileView(user: user)

                //creates item on tab
                .tabItem {
                    
                    Image(systemName: "star")
                    Text("RECAP")
                }.tag(1)
            }
            //tab to get users to their daily grid
            TodayView()
                .tabItem {
                    
                    Image(systemName: "squareshape.split.2x2")
                    Text("TODAY")
                }.tag(2)
            //tab to get users to the camera
            CameraView()
                .tabItem {
                    
                    Image(systemName: "camera.metering.center.weighted")
                    Text("CAMERA")
                }.tag(3)
            
    
        }
    //calls the environment object to give views access to camera
    .environmentObject(camera)
    .navigationBarHidden(true)
    .accentColor(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
    .font(.largeTitle)
            }
            
    }
}



struct ContentView_Previews: PreviewProvider {
    static var viewModel = Authentication()

    static var previews: some View {
        ContentView().environmentObject(viewModel)
    }
}
