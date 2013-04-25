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


@interface BYUViewController ()
@property (nonatomic, retain) NSMutableArray *capturedImages;
@property (nonatomic, strong) UIImagePickerController *cameraViewController;
@property (nonatomic, retain) UIView *overlay;

@property (retain, nonatomic) UIButton *Flash;
@property (retain, nonatomic) UIButton *SwitchRear;
@property (retain, nonatomic) UIBarButtonItem *PhotoAlbum;
@property (retain, nonatomic) UIBarButtonItem *CameraButton;
@property (retain, nonatomic) UIToolbar *Toolbar;
@property (retain, nonatomic) UIButton *modeSwitch;

@end

@implementation BYUViewController


- (void)viewDidLoad
{
    NSLog(@"view did load");
    [super viewDidLoad];
    self.capturedImages = [NSMutableArray array];
    self.cameraViewController = [[UIImagePickerController alloc] init];
    self.capturedImages = [[NSMutableArray alloc] init];
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenWidth = screenRect.size.width;
    //CGFloat screenHeight = screenRect.size.height;
    
    self.overlay = [[UIView alloc] initWithFrame:screenRect];
    self.overlay.backgroundColor = [UIColor clearColor];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    self.view.backgroundColor = [UIColor clearColor];
    self.Toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, height - 36,width, 36)];
    
    // modeSwitch button
    self.modeSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
    self.modeSwitch.frame = CGRectMake(width/2-40, 0, 79, 27);
    //[self.modeSwitch setImage:[UIImage imageNamed:@"gear_64.png"] forState:UIControlStateNormal];
    [self.modeSwitch addTarget:self action:@selector(modeSwitch:) forControlEvents:UIControlEventTouchUpInside];
    
    // Flash button
    self.Flash = [UIButton buttonWithType:UIButtonTypeCustom];
    self.Flash.frame = CGRectMake(9, height - height, 81, 32);
    self.Flash.tintColor = [UIColor clearColor];
    [self.Flash setTitle:@"on" forState:UIControlStateNormal];
    [self.Flash setTitle:@"off" forState:UIControlStateSelected];
    [self.Flash addTarget:self action:@selector(Flash:) forControlEvents:UIControlEventTouchUpInside];
    
    // Switch camera button
    self.SwitchRear = [UIButton buttonWithType:UIButtonTypeCustom];
    self.SwitchRear.frame = CGRectMake(width - 80, 0 , 70, 32);
    [self.SwitchRear setTitle:@"Rear" forState:UIControlStateNormal];
    [self.SwitchRear setTitle:@"Front" forState:UIControlStateSelected];
    [self.SwitchRear addTarget:self action:@selector(SwitchCamera:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.CameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(Capture:)];
    self.PhotoAlbum =  [[UIBarButtonItem alloc] initWithTitle:@"Gallery" style:UIBarButtonItemStyleBordered target:self action:@selector(Library:)];
    
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIImage *image = [UIImage imageNamed:@"iphone-camera-button.png"];
    self.CameraButton.image = image;
    //[self.Flash setImage:image forState:UIControlStateNormal];
    NSArray *items = [NSArray arrayWithObjects: self.PhotoAlbum, flexibleSpace1, self.CameraButton, flexibleSpace2, nil];
    
    self.Toolbar.items = items;
    self.Toolbar.tintColor = [UIColor blackColor];
    
    [self.overlay addSubview:self.modeSwitch];
    [self.overlay addSubview:self.Toolbar];
    [self.overlay addSubview:self.Flash];
    [self.overlay addSubview:self.SwitchRear];    
    
}
- (void)viewDidAppear: (BOOL)animated
{
    NSLog(@"viewDidAppear");
    
    [self showCamera:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showCamera:(id)sender {

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self.cameraViewController setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        //Available both for still images and movies
        self.cameraViewController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        
        self.cameraViewController.allowsEditing = YES;
        self.cameraViewController.showsCameraControls = NO;
        self.cameraViewController.navigationBarHidden = YES;
        self.cameraViewController.toolbarHidden = YES;
        self.cameraViewController.cameraViewTransform = CGAffineTransformScale(self.cameraViewController.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
        
        // set the overlay view
        self.cameraViewController.cameraOverlayView = self.overlay;
        
        // set the default flashMode to be on
        [self.cameraViewController setCameraFlashMode:UIImagePickerControllerCameraFlashModeOn];
        
        //[self addChildViewController:self.cameraViewController];
       
    }
    else
    {
        [self.cameraViewController setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
    
    self.cameraViewController.delegate = self;
    //[self.cameraViewController setDelegate:self];
    
    [self presentViewController:self.cameraViewController animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    //UIImage *image = [UIImage imageNamed:@"sample.png"];
    
    
    if(CFStringCompare((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        if(self.cameraViewController.editing)
        {
            NSLog(@"Editing mode");
            UIImage *selectedImage = (UIImage *) [info objectForKey: UIImagePickerControllerEditedImage];
            if(!self.modeSwitch.selected)
            {
                [self.capturedImages addObject:selectedImage];
            }
            else
            {
                for (NSInteger n = 0;n < [self.capturedImages count]; n = n+1)
                {
                    UIImageWriteToSavedPhotosAlbum(self.capturedImages[n], nil, nil, nil);
                }
                NSLog(@"pic is saved");
            }
        }
        else
        {
            NSLog(@"Normal mode");
            UIImage *selectedImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
            if(!self.modeSwitch.selected)
            {
                [self.capturedImages addObject:selectedImage];
            }
            else
            {
                for (NSInteger n = 0;n < [self.capturedImages count]; n = n+1)
                {
                    UIImageWriteToSavedPhotosAlbum(self.capturedImages[n], nil, nil, nil);
                }
                NSLog(@"pic is saved");
            }
        }
        NSLog(@"image picked");
        //image = seletctedImage;
        
        

    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"library did cancel");
    [UIView transitionWithView:self.cameraViewController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlDown animations:^{[self.cameraViewController setSourceType:UIImagePickerControllerSourceTypeCamera];} completion:nil];
}

- (void)Flash:(id)sender
{
    self.Flash.selected = !self.Flash.selected;
    if ([self.cameraViewController cameraFlashMode] == -1)
    {
        NSLog(@"Flash on");
        [self.cameraViewController setCameraFlashMode:UIImagePickerControllerCameraFlashModeOn];
    }
    else
    {
        NSLog(@"Flash off");
        [self.cameraViewController setCameraFlashMode:UIImagePickerControllerCameraFlashModeOff];
    }
}

- (void)Capture:(id)sender
{
    [self.cameraViewController takePicture];
    NSLog(@"a picture was captured");
}

- (void)SwitchCamera:(id)sender
{
    self.SwitchRear.selected = !self.SwitchRear.selected;
    if(self.cameraViewController.cameraDevice == UIImagePickerControllerCameraDeviceRear)
    {
        [UIView transitionWithView:self.cameraViewController.view duration:0.7 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{self.cameraViewController.cameraDevice = UIImagePickerControllerCameraDeviceFront;} completion:nil];
        //self.cameraViewController.cameraDevice = UIImagePickerControllerCameraDeviceFront
    }
    else
    {
        [UIView transitionWithView:self.cameraViewController.view duration:0.7 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{ self.cameraViewController.cameraDevice = UIImagePickerControllerCameraDeviceRear;} completion:nil];

       
    }
    
}

- (void)modeSwitch:(id)sender
{
    if(self.modeSwitch.selected)
    {
        NSLog(@"I am selected");
    }
    else
    {
        NSLog(@"I am not selected");
    }
        
    self.modeSwitch.selected = !self.modeSwitch.selected;
}

- (void)Library:(id)sender
{
    [UIView transitionWithView:self.cameraViewController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{[self.cameraViewController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];} completion:nil];
}

@end
