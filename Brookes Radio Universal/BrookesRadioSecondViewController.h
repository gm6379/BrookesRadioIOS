//
//  BrookesRadioSecondViewController.h
//  Brookes Radio Universal
//
//  Created by george mcdonnell on 17/09/2013.
//  Copyright (c) 2013 george mcdonnell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MessageUI/MessageUI.h>
#import <FacebookSDK/FacebookSDK.h>

@interface BrookesRadioSecondViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIBarButtonItem *actionButton;
@property (nonatomic, retain) UIActionSheet *actionSheet;

-(IBAction)scheduleButtonClick:(id)sender;
-(IBAction)getInvolvedButtonClick:(id)sender;

@end
