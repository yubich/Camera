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

@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;

@property (nonatomic, weak) BYUViewController *delegate;

@end
