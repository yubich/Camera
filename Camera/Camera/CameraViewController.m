//
//  CameraViewController.m
//  Camera
//
//  Created by BINGCHEN YU on 2/19/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import "CameraViewController.h"
#import "CustomOverlayView.h"

@interface CameraViewController ()
//@property (nonatomic, retain) NSMutableArray *capturedImages;

@end

@implementation CameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.delegate = self;
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"view 2 did load");
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
