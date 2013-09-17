//
//  BrookesRadioFirstViewController.m
//  Brookes Radio Universal
//
//  Created by george mcdonnell on 17/09/2013.
//  Copyright (c) 2013 george mcdonnell. All rights reserved.
//

#import "BrookesRadioFirstViewController.h"

@interface BrookesRadioFirstViewController ()

@end

@implementation BrookesRadioFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
