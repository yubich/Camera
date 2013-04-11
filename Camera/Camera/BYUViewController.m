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
@property (retain, nonatomic) UISwitch *modeSwitch;

@end

@implementation BYUViewController


- (void)viewDidLoad
{
    NSLog(@"view did load");
    [super viewDidLoad];
    self.capturedImages = [NSMutableArray array];
    self.cameraViewController = [[UIImagePickerController alloc] init];
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenWidth = screenRect.size.width;
    //CGFloat screenHeight = screenRect.size.height;
    
    self.overlay = [[UIView alloc] initWithFrame:screenRect];
    self.overlay.backgroundColor = [UIColor clearColor];
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
    
    //self.cameraViewController = [[UIImagePickerController alloc] init];
    
    //if the device has a camera, then take a picture, else pick one from photo library
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    self.view.backgroundColor = [UIColor clearColor];
    self.modeSwitch = [[UISwitch alloc] initWithFrame: CGRectMake(243, 260, 79, 27)];
    self.Toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, height - 47,width, 47)];
    self.Flash = [[UIButton alloc] initWithFrame:CGRectMake(9, height - height, 81, 32)];
    [self.Flash addTarget:self action:@selector(Flash:) forControlEvents:UIControlEventTouchUpInside];
    
    self.SwitchRear = [[UIButton alloc] initWithFrame:CGRectMake(240, 260, 70, 32)];
    self.CameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(btnCapture:)];
    self.PhotoAlbum =  [[UIBarButtonItem alloc] initWithTitle:@"Gallery" style:UIBarButtonItemStyleBordered target:self action:@selector(btnLibrary:)];
    
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIImage *image = [UIImage imageNamed:@"iphone-camera-button.png"];
    self.CameraButton.image = image;
    [self.Flash setImage:image forState:UIControlStateNormal];
    NSArray *items = [NSArray arrayWithObjects: self.PhotoAlbum, flexibleSpace1, self.CameraButton, flexibleSpace2, nil];
    
    self.Toolbar.items = items;
    self.Toolbar.tintColor = [UIColor blackColor];
    
    [self.overlay addSubview:self.modeSwitch];
    [self.overlay addSubview:self.Toolbar];
    [self.overlay addSubview:self.Flash];
    [self.overlay addSubview:self.SwitchRear];
    

    
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self.cameraViewController setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        //Available both for still images and movies
        self.cameraViewController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        
        self.cameraViewController.editing = NO;
        self.cameraViewController.showsCameraControls = NO;
        self.cameraViewController.navigationBarHidden = YES;
        self.cameraViewController.toolbarHidden = YES;
        self.cameraViewController.cameraViewTransform = CGAffineTransformScale(self.cameraViewController.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
        
        
        self.cameraViewController.cameraOverlayView = self.overlay;
        //[self addChildViewController:self.cameraViewController];
       
    }
    else{
        [self.cameraViewController setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
     
        //[self.cameraViewController setDelegate:self];
    
    [self.cameraViewController setSourceType:UIImagePickerControllerSourceTypeCamera];
    
    [self presentViewController:self.cameraViewController animated:YES completion:nil];
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
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"library did cancel");
    [self showCamera:self];
}

- (void)Flash:(id)sender
{
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


@end
