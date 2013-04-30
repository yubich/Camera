//
//  PreViewController.m
//  Camera
//
//  Created by BINGCHEN YU on 4/25/13.
//  Copyright (c) 2013 BINGCHEN YU. All rights reserved.
//

#import "PreViewController.h"

@interface PreViewController ()



@end

@implementation PreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.picView = [[UIImageView alloc] init];
        [self.view addSubview:self.picView];

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

@end
