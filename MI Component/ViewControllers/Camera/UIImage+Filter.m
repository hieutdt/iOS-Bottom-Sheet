//
//  UIImage+Filter.m
//  MI Component
//
//  Created by HieuTDT on 10/24/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import "UIImage+Filter.h"

@implementation UIImage (Filter)

- (UIImage *)addFilter:(NSString *)filterType {
    
    CIFilter *filter = [CIFilter filterWithName:filterType];
    
    // Convert UIImage to CIImage and set as input
    CIImage *ciInput = [CIImage imageWithCGImage:self.CGImage];
    
    if (filter) {
        [filter setValue:ciInput forKey:kCIInputImageKey];
        
        // Get output CIImage, render as CGImage first to retain
        // proper UIImage scale
        CIImage *ciOutput = [filter outputImage];
        
        // Return the image
        return [UIImage imageWithCIImage:ciOutput];
    }
    
    return nil;
}

- (UIImage *)fixOrientation {
    if (self.imageOrientation == UIImageOrientationUp) {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *normalizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return normalizeImage;
}

@end
