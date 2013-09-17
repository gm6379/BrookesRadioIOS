//
//  BrookesRadioSecondViewController.m
//  Brookes Radio Universal
//
//  Created by george mcdonnell on 17/09/2013.
//  Copyright (c) 2013 george mcdonnell. All rights reserved.
//

#import "BrookesRadioSecondViewController.h"

@interface BrookesRadioSecondViewController ()

@end

@implementation BrookesRadioSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
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
