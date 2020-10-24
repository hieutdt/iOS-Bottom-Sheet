//
//  AppUtility.swift
//  MI Component
//
//  Created by HieuTDT on 10/24/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import UIKit

class AppUtility: NSObject {

    @objc public static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
    
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.oritentationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    @objc public static func lockOrientation(_ orientation: UIInterfaceOrientationMask,
                                       andRotateTo rotateOrientation:UIInterfaceOrientation) {
   
        self.lockOrientation(orientation)
    
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}
