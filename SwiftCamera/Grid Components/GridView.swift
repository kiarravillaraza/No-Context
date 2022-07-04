//
//  GridView.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/30/22.
//
//
/*
 File that creates the grid layout for the today view
 */

import SwiftUI

struct CellContent2: View {
    /*
     structure to design the grid cells for the grid
     */
    @EnvironmentObject var camera: CameraModel
    
    //image that is being displayed in the cell
    var post: UIImage

    var body: some View {
        //checks to see if the final grid is not empty so it can display the photos
        if camera.finalGrid?.grid != nil  {
        if #available(iOS 15.0, *) {
            //iterates through the final grid array to put each of the four pictures into their own cell
            ForEach(camera.finalGrid!.grid, id: \.self) { picture in
                Image(uiImage: picture)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 184, height: 210)
                                .background(.black)
                                .cornerRadius(2)
                        }
        } else {
            // Fallback on earlier versions of iOS
            }
        }
    }
}

struct GridView: View {
    @EnvironmentObject var camera: CameraModel
        
    //items to build the grid, there are 2 items to create two colums (2x2 grid)
    private var gridItems = [GridItem(.flexible()),  GridItem(.flexible())]
    
    var body: some View {
        if camera.finalGrid?.grid != nil {
          ScrollView{
          //declares a vertical grid that contains 4 instances of the custom cell view created above
          LazyVGrid(columns: gridItems, spacing: 5) {
              //fills the grid with the cells created above
              ForEach((camera.finalGrid!.grid), id: \.self) {
                  picture in
                  CellContent2(post: picture)
              }
          }
          .padding(9)
          }
      }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            GridView()
                .previewInterfaceOrientation(.portrait)
        } else {
            // Fallback on earlier versions
        }
    }
}
