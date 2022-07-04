//
//  TodayView.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/17/22.
//
/*
 File that houses the daily grid view
 */
import SwiftUI
import UserNotifications


struct TodayView: View {
    
    @EnvironmentObject var camera: CameraModel
    @State private var showButton = true
    @ObservedObject var viewModel = GridUploader()
    @EnvironmentObject var viewModel2: Authentication

    var body: some View {
        VStack{
            
            if camera.finalGrid != nil {
            Text("TODAY")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .offset(y: 15)
            } else if (camera.collection.isEmpty == false) {
                Text("TODAY")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            } else {
                Text("TODAY")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            //if the grid has been filled, display grid
            if camera.finalGrid != nil {
                GridView()
                
            //if user is in the process of filling grid, display this
            } else if (camera.collection.isEmpty == false) {
                Image("in_progress")
                    .resizable()
                    .scaledToFit()
                    .offset(y: 40)

            //if user has yet to start grid, display instructions
            } else {
                Image("instructions")
                    .resizable()
                    .scaledToFit()
                    .offset(y: 55)
            }

        Spacer()
            if showButton{
            Button {
                showButton = false
                //clearing any previous notification requests
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
               
                //first part of notification - content
                let content = UNMutableNotificationContent()
                content.title = "No Context"
                content.subtitle = "Capture the moment!"
                content.body = "Take a picture using the camera."
                content.sound = UNNotificationSound.default
                UIApplication.shared.applicationIconBadgeNumber = 0
                //second part of notification - trigger (repeat every 6 hours)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (360*60), repeats: true)
                
                //third part of notification - request
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                print("DEBUG: Notification triggered!")
                
              /*  creates a grid document in the "grids" collection in Firebase where user will later update the document with an array of strings for their captured images that reference their location in storage
               */
                viewModel.uploadGrid(withGrid: camera.collection)

            } label: {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
                    .clipShape(Capsule())
                    .padding(.bottom, 180.0)
                    .offset(y: 70)
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            } else {
                Button {
                    
                    showButton = true

                    /*
                     Updates grid document created above, this fills the grid array with the strings
                     */
                    viewModel2.gridPhotoUploader2(camera.finalGrid!.grid)
                    print("DEBUG: Grid has been updated with photos successfully!")
        
                } label: {
                    Text("Post Grid")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color(#colorLiteral(red: 0.4329035282, green: 0.6408515573, blue: 0.7863608599, alpha: 1)))
                        .clipShape(Capsule())
                        .padding(.bottom, 150)
                }
            }
    }
    }
    
}

struct TodayView_Previews: PreviewProvider {
    static var camera = CameraModel()
    
    static var previews: some View {
        TodayView().environmentObject(camera)
    }
}
