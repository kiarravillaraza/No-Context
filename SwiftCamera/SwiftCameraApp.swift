//
//  SwiftCameraApp.swift
//  SwiftCamera
//
//
//

import SwiftUI
import Firebase

@main
struct SwiftCameraApp: App {
    
    @StateObject var viewModel = Authentication()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(viewModel)
        }
    }
}
