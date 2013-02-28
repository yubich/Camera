//
//  BYUViewController.m
//  Camera
//
//  Created by BINGCHEN YU on 2/11/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#define CAMERA_TRANSFORM_X 1
#define CAMERA_TRANSFORM_Y 1

#import "BYUViewController.h"
#import "CustomOverlayView.h"

@interface BYUViewController ()
@property (nonatomic, retain) NSMutableArray *capturedImages;
@property (nonatomic, strong) CameraViewController *cameraViewController;

@end

@implementation BYUViewController
{
    CustomOverlayView *overlay;
    BOOL didCancel;
}

@synthesize cameraViewController;

- (void)viewDidLoad
{
    NSLog(@"view did load");
    [super viewDidLoad];
    self.capturedImages = [NSMutableArray array];
    self.cameraViewController = [[CameraViewController alloc] init];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    overlay = [[CustomOverlayView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
}

- (void)viewDidAppear: (BOOL)animated
{
    NSLog(@"view appeared");
    
    [self showCamera:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showCamera:(id)sender {
    
    self.cameraViewController.imagePickerController = [[UIImagePickerController alloc] init];
    
    //if the device has a camera, then take a picture, else pick one from photo library
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self.cameraViewController.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        //Available both for still images and movies
        self.cameraViewController.imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        
        //No Editting of the pickture
        self.cameraViewController.imagePickerController.editing = NO;
        //self.cameraViewController.imagePickerController.showsCameraControls = NO;
        self.cameraViewController.imagePickerController.cameraViewTransform = CGAffineTransformScale(self.cameraViewController.imagePickerController.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
        
        if(overlay.flashButton.hidden)
        {
            overlay.flashButton.hidden = NO;
        }

    }
    else{
        [self.cameraViewController.imagePickerController setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
        [self.cameraViewController.imagePickerController setDelegate:self];
    
    if(!didCancel)
    {
        [self presentViewController:self.cameraViewController.imagePickerController animated:YES completion:nil];
    }
    else
    {
        didCancel = NO;
    }
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *image = [UIImage imageNamed:@"sample.png"];
    
    
    if(CFStringCompare((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        UIImage *seletctedImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        NSLog(@"image picked");
        image = seletctedImage;
    }
    
    // if the picture is the one we selected (in this case, the first one we took),
    // temperarily store that in an array and hide it.
    if (self.capturedImages.count == 0)
    {
        NSLog(@"image stored at 0");
        [self.capturedImages addObject:image];
        //UIImageWriteToSavedPhotosAlbum(self.capturedImages[0], nil, nil, nil);
    }
    // when the second one is done, replace it with the previous one.
    else
    {
        [self.capturedImages addObject:image];
        image = self.capturedImages[self.capturedImages.count-2];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
}

- (void)takePicture
{
    [self.cameraViewController.imagePickerController takePicture];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    didCancel = YES;
    NSLog(@"library did cancel");
    [self showCamera:self];
}

- (void)changeCamera
{
    if(self.cameraViewController.imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        self.cameraViewController.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        overlay.flashButton.hidden = NO;
    }
    else
    {
        self.cameraViewController.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        overlay.flashButton.hidden = YES;
    }
}

- (void)showLibary
{
    self.cameraViewController.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
}

@end
