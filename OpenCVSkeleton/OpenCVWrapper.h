//
//  OpenCVWrapper.h
//  OpenCVSkeleton
//
//  Created by Kaz Namba on 2019/10/21.
//  Copyright © 2019 Kaz Namba. All rights reserved.
//

#ifndef OpenCVWrapper_h
#define OpenCVWrapper_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 HandlerDelegate protocol
 */
@protocol HandlerDelegate <NSObject>

@optional
- (void)didProcessed;

@end


/**
 Objective-C implementations using OpenCV
 */
@interface OpenCVWrapper : NSObject

/**
 delegate objects
 */
@property (weak, nonatomic) id <HandlerDelegate> delegate;

- (void)createCameraWithParentView:(UIImageView *)parentView;

- (void)start;

- (void)stop;

@end

#endif /* OpenCVWrapper_h */
