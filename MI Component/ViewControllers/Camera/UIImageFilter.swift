//
//  UIImageFilter.swift
//  MI Component
//
//  Created by HieuTDT on 10/24/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

import Foundation
import UIKit

class FilterType: NSObject {
    
    var value: String = ""
    
    init(_ value: String) {
        super.init()
        self.value = value
    }
    
    static var Chrome = FilterType("CIPhotoEffectChrome")
    
    static var Fade = FilterType("CIPhotoEffectFade")
    
    static var Instant = FilterType("CIPhotoEffectInstant")
    
    static var Mono = FilterType("CIPhotoEffectMono")
    
    static var Noir = FilterType("CIPhotoEffectNoir")
    
    static var Process = FilterType("CIPhotoEffectProcess")
    
    static var Tonal = FilterType("CIPhotoEffectTonal")
        
    static var Transfer = FilterType("CIPhotoEffectTransfer")
}

@objc extension UIImage {
    
    @objc func addFilter(filter: FilterType) -> UIImage {
        
        let filter = CIFilter(name: filter.value)
        
        // Convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: self)
        
        filter?.setValue(ciInput, forKey: "inputImage")
        
        // Get output CIImage, render as CGImage first to retain
        // proper UIImage scale
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        
        let cgImage = ciContext.createCGImage(ciOutput!, from: ciOutput!.extent)
        
        // Return the image
        return UIImage(cgImage: cgImage!)
    }
}
