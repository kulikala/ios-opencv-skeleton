//
//  CvVideoCamera+ContentMode.h
//  OpenCVSkeleton
//
//  Created by Kaz Namba on 2019/10/21.
//  Copyright © 2019 Kaz Namba. All rights reserved.
//

#ifndef CvVideoCamera_ContentMode_h
#define CvVideoCamera_ContentMode_h

#import <opencv2/videoio/cap_ios.h>
#import <UIKit/UIKit.h>

@interface CvVideoCamera(WithContentMode)

- (void)startWithContentMode:(UIViewContentMode)contentMode;

@end

#endif /* CvVideoCamera_ContentMode_h */
