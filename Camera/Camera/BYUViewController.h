//
//  BYUViewController.h
//  Camera
//
//  Created by BINGCHEN YU on 2/11/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYUViewController : UIViewController
<UINavigationBarDelegate,UIImagePickerControllerDelegate>
- (IBAction)takePicture:(id)sender;

@end
