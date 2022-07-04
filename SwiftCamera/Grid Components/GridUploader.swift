//
//  GridUploader.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/30/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class GridUploader: ObservableObject {
    
    let service = GridService()
    
    func uploadGrid(withGrid grid: [UIImage]) {
        service.postGrid(grid: grid)
    }
    
    
    
}
