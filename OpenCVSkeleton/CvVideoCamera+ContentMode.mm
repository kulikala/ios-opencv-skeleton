//
//  CvVideoCamera+ContentMode.mm
//  OpenCVSkeleton
//
//  Created by Kaz Namba on 2019/10/21.
//  Copyright © 2019 Kaz Namba. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreMedia/CoreMedia.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#include "CvVideoCamera+ContentMode.h"

@implementation CvVideoCamera(WithContentMode)

- (void)startWithContentMode:(UIViewContentMode)contentMode {
    [self start];

    // Get the default camera device
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera
                                                                 mediaType:AVMediaTypeVideo
                                                                  position:self.defaultAVCaptureDevicePosition];

    // Get current video dimensions
    CMVideoDimensions dimensions = CMVideoFormatDescriptionGetDimensions(device.activeFormat.formatDescription);
    CGSize resolution = CGSizeMake(dimensions.width, dimensions.height);
    
    // Consider portrait
    if (self.defaultAVCaptureVideoOrientation == AVCaptureVideoOrientationPortrait || self.defaultAVCaptureVideoOrientation == AVCaptureVideoOrientationPortraitUpsideDown) {
        resolution = CGSizeMake(resolution.height, resolution.width);
    }
    
    NSLog(@"video dimensions = %f x %f", resolution.width, resolution.height);
    
    if (resolution.width == 0 || resolution.height == 0) {
        return;
    }
    if (self.parentView.layer.sublayers == nil) {
        return;
    }
    
    // Get parentView frame
    CGRect parentFrame = self.parentView.layer.frame;
    NSLog(@"parentView = %@", NSStringFromCGRect(parentFrame));
    
    CALayer *layer = [self.parentView.layer.sublayers objectAtIndex:0];
    NSLog(@"[before] frame = %@, position = %@", NSStringFromCGRect(layer.frame), NSStringFromCGPoint(layer.position));
    
    // Calculate ratio to frame size
    CGFloat ratiox = parentFrame.size.width / resolution.width;
    CGFloat ratioy = parentFrame.size.height / resolution.height;

    // Fit or fill
    CGFloat ratio;
    switch (contentMode) {
        case UIViewContentModeScaleAspectFit:
            ratio = (ratiox < ratioy) ? ratiox : ratioy;
            break;

        case UIViewContentModeScaleAspectFill:
            ratio = (ratiox > ratioy) ? ratiox : ratioy;
            break;

        default:
            NSLog(@"Given contentMode is not supported");
            return;
    }
    NSLog(@"ratio = %.3f", ratio);

    // Crop layer
    CGFloat x, y, w, h;
    w = resolution.width * ratio;
    h = resolution.height * ratio;
    x = (parentFrame.size.width - w) / 2;
    y = (parentFrame.size.height - h) / 2;
    layer.frame = CGRectMake(x, y, w, h);
    NSLog(@"[after] frame = %@, position = %@", NSStringFromCGRect(layer.frame), NSStringFromCGPoint(layer.position));
}

@end
