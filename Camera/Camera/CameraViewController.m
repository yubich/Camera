//
//  CameraViewController.m
//  Camera
//
//  Created by BINGCHEN YU on 2/13/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface CameraViewController ()

@end

@implementation CameraViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage * image = [UIImage imageNamed:@"sample.png"];
    
    
    if(CFStringCompare((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        UIImage *seletctedImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        NSLog(@"image picked");
    }
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
}
@end
