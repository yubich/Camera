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
@property (retain, nonatomic) UIButton *hide;

@property (retain, nonatomic) PreViewController *preViewController;

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
    self.modeSwitch.selected = NO;
    
    // hide button
    self.hide = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hide.frame = CGRectMake(width-60, height/2-30, 60, 60);
    [self.hide addTarget:self action:@selector(hidePic:) forControlEvents:UIControlEventTouchUpInside];
    self.hide.selected = YES;
    
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
    
    // configuring the toolbar
    self.CameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(Capture:)];
    self.PhotoAlbum =  [[UIBarButtonItem alloc] initWithTitle:@"Gallery" style:UIBarButtonItemStyleBordered target:self action:@selector(Library:)];
    
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *items = [NSArray arrayWithObjects: self.PhotoAlbum, flexibleSpace1, self.CameraButton, flexibleSpace2, nil];
    
    self.Toolbar.items = items;
    self.Toolbar.tintColor = [UIColor blackColor];
    
    // adding everything to the view
    [self.overlay addSubview:self.modeSwitch];
    [self.overlay addSubview:self.Toolbar];
    [self.overlay addSubview:self.Flash];
    [self.overlay addSubview:self.SwitchRear];
    [self.overlay addSubview:self.hide];
    
    //self.preViewController = [[PreViewController alloc] init];
    
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
        
        // change default settings
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
        UIImage *selectedImage = (UIImage *) [info objectForKey: UIImagePickerControllerOriginalImage];
        
        /*
        if(self.cameraViewController.sourceType != UIImagePickerControllerSourceTypeCamera)
        {
            [self.preViewController.picView setImage:selectedImage];
            [self.cameraViewController presentViewController:self.preViewController animated:YES completion:nil];
            NSLog(@"shift to preViewController");
            return;
        }
        */
        
        // when hidden mode is on, store pics into capturedImages array
        if(self.hide.selected)
        {
            [self.capturedImages addObject:selectedImage];
            NSLog(@"pic is hidden");
        }
        else
        {
            if(!self.modeSwitch.selected)
            {
                UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
                NSLog(@"pic is saved");
            }
            else
            {
                for (NSInteger n = 0;n < [self.capturedImages count]; n = n+1)
                {
                    UIImageWriteToSavedPhotosAlbum(self.capturedImages[n], nil, nil, nil);
                }
                [self.capturedImages removeAllObjects];
            }
            //NSLog(@"pic is saved");
        }
        
        NSLog(@"image picked");
        //image = seletctedImage;
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"library did cancel");
    self.SwitchRear.selected = NO;
    self.Flash.selected = NO;
    [UIView transitionWithView:self.cameraViewController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlDown animations:^{[self.cameraViewController setSourceType:UIImagePickerControllerSourceTypeCamera];} completion:nil];
}

// flashlight 
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

// function of capturing pics
- (void)Capture:(id)sender
{
    [self.cameraViewController takePicture];
    NSLog(@"a picture was captured");
}

// switch camera device
- (void)SwitchCamera:(id)sender
{
    self.SwitchRear.selected = !self.SwitchRear.selected;
    if(self.cameraViewController.cameraDevice == UIImagePickerControllerCameraDeviceRear)
    {
        // animation when change the view
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
    self.modeSwitch.selected = !self.modeSwitch.selected;
    
    if(self.modeSwitch.selected)
    {
        NSLog(@"I am selected");
    }
    else
    {
        NSLog(@"I am not selected");
    }
}

- (void)Library:(id)sender
{
    [UIView transitionWithView:self.cameraViewController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{[self.cameraViewController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];} completion:nil];
}

// function of hiding pics
- (void) hidePic:(id)sender
{
    self.hide.selected = !self.hide.selected;
    
    if(self.hide.selected)
    {
        NSLog(@"hidden mode");
    }
    else
    {
        NSLog(@"normal mode");
    }
}

@end
