//
//  BYUViewController.m
//  Camera
//
//  Created by BINGCHEN YU on 2/11/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import "BYUViewController.h"


@interface BYUViewController ()

@end

@implementation BYUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self performSegueWithIdentifier:@"camera" sender:self];
    
        
}

- (void)viewDidAppear: (BOOL)animated
{
    NSLog(@"view appeared");
    
    [self takePicture:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicture:(id)sender {
    CameraViewController *imagePicker = [[CameraViewController alloc] init];
    
    //if the device has a camera, then take a picture, else pick one from photo library
    if([CameraViewController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        //Available both for still images and movies
        imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        
        //No Editting of the pickture
        imagePicker.editing = NO;

    }
    else{
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
        [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage * image = [UIImage imageNamed:@"sample.png"];
    
    
    if(CFStringCompare((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        UIImage *seletctedImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        NSLog(@"image picked");
        image = seletctedImage;
    }
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
}
@end
