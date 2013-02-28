//
//  CustomOverlayView.h
//  Camera
//
//  Created by BINGCHEN YU on 2/25/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"
#import "BYUViewController.h"


@interface CustomOverlayView : UIView

@property (nonatomic, weak) BYUViewController *delegate;
@property (nonatomic, weak) UIButton *pictureButton;
@property (nonatomic, weak) UIButton *flashButton;
@property (nonatomic, weak) UIButton *changeCameraButton;
@property (nonatomic, weak) UIButton *lastPicture;


@end
