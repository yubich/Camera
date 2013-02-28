//
//  CustomOverlayView.m
//  Camera
//
//  Created by BINGCHEN YU on 2/25/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import "CustomOverlayView.h"



@implementation CustomOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        
        // add the bar
        //UIImage *image =[UIImage imageNamed:@"bar"];
        UIImageView *imageView =[[UIImageView alloc] init];
        imageView.frame = CGRectMake(0,415, 320, 65);
        [self addSubview:imageView];
        
        // add the button of taking picture
        self.pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pictureButton.frame = CGRectMake(90, 385, 130, 100);
        /*UIImage *buttonImageNormal =[UIImage imageNamed:@"take_picture"];
        [self.pictureButton setImage:buttonImageNormal forState:UIControlStateNormal];
        [self.pictureButton setImage:buttonImageNormal forState:UIControlStateDisabled];*/
        [self.pictureButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.pictureButton];
        
        // add the button of going to gallery
        self.lastPicture = [UIButton buttonWithType:UIButtonTypeCustom];
        self.lastPicture.frame = CGRectMake(20, 423, 50, 50);
        [self addSubview:self.lastPicture];
        
        // add the flash button
        if([UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear])
        {
            self.flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.flashButton.frame = CGRectMake(10, 30, 57.5, 57.5);
            /*buttonImageNormal = [UIImage imageNamed:@"flash02"];
            [self.flashButton setImage:buttonImageNormal forState:UIControlStateNormal];*/
            [self.flashButton addTarget:self action:@selector(setFlashButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.flashButton];
        }
        
        if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
        {
            self.changeCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.changeCameraButton.frame = CGRectMake(250, 30, 57.5, 57.5);
            /*buttonImageNormal =[UIImage imageNamed: @"switch_button"];
            [self.changeCameraButton setImage:buttonImageNormal forState:UIControlStateNormal];*/
            [self.changeCameraButton addTarget:self action:@selector(changeCameraButton) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.changeCameraButton];
            
        }
        
        // Initialization code
    }
    return self;
}

- (void)takePicture:(id)sender
{
    self.pictureButton.enabled = NO;
    [self.delegate takePicture];
}

- (void)setFlash:(id)sender
{
    //[self.delegate changeFlash:sender];
}

- (void)changCamera:(id)sender
{
    [self.delegate changeCamera];
}

- (void)showCameraRoll:(id)sender
{
    [self.delegate showLibary];
}

/*          
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
