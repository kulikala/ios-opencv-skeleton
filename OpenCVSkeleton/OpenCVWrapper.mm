//
//  OpenCVWrapper.mm
//  OpenCVSkeleton
//
//  Created by Kaz Namba on 2019/10/21.
//  Copyright © 2019 Kaz Namba. All rights reserved.
//


#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/videoio/cap_ios.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CvVideoCamera+ContentMode.h"
#import "OpenCVWrapper.h"

using namespace cv;
using namespace std;


/*
 Static constants
 */

static const AVCaptureDevicePosition kDevicePosition = AVCaptureDevicePositionBack;
static const AVCaptureSessionPreset kSessionPreset = AVCaptureSessionPresetHigh;
static const AVCaptureVideoOrientation kVideoOrientation = AVCaptureVideoOrientationPortrait;
static const long kFPS = 10;


/**
 Objective-C implementations using OpenCV
 */
@interface OpenCVWrapper() <CvVideoCameraDelegate> {
@private
    CvVideoCamera *cvCamera;
}

@end


@implementation OpenCVWrapper

/*
 Public methods
 */

- (void)createCameraWithParentView:(UIImageView *)parentView {
    cvCamera = [[CvVideoCamera alloc] initWithParentView:parentView];
    
    cvCamera.defaultAVCaptureDevicePosition = kDevicePosition;
    cvCamera.defaultAVCaptureSessionPreset = kSessionPreset;
    cvCamera.defaultAVCaptureVideoOrientation = kVideoOrientation;
    cvCamera.defaultFPS = kFPS;
    cvCamera.grayscaleMode = NO;
    cvCamera.rotateVideo = NO;
    
    cvCamera.delegate = self;
}

- (void)start {
    [cvCamera startWithContentMode:UIViewContentModeScaleAspectFill];
}

- (void)stop {
    [cvCamera stop];
}


/*
 Private methods
 */

- (void)processImage:(Mat &)image {
}

@end
