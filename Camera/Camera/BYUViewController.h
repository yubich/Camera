//
//  BYUViewController.h
//  Camera
//
//  Created by BINGCHEN YU on 2/11/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <MobileCoreServices/MobileCoreServices.h>



@interface BYUViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
- (IBAction) showCamera:(id)sender;
- (void) Flash:(id)sender;
- (void) Capture:(id)sender;
- (void) SwitchCamera:(id)sender;
- (void) modeSwitch:(id)sender;
- (void) Library:(id)sender;
/*
- (IBAction) backButton:(id)sender;
- (IBAction) doneButton:(id)sender;
- (void) changeFlash:(id)sender;
*/


@end
