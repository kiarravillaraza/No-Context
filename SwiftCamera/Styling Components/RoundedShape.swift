//
//  RoundedShape.swift
//  SwiftCamera
//
//  Created by Kiarra Villaraza on 6/22/22.
//
/*
 File that houses the rounded shape component used for styling header, used in login, registration, and profile picture view
 */

import Foundation
import SwiftUI

struct RoundedShape: Shape {
    
    var corners: UIRectCorner
        
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 80, height: 80))
        
        return Path(path.cgPath)
        
    }
}
