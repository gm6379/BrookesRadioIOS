//
//  BrookesRadioFirstViewController.h
//  Brookes Radio Universal
//
//  Created by george mcdonnell on 17/09/2013.
//  Copyright (c) 2013 george mcdonnell. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MessageUI/MessageUI.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <FacebookSDK/FacebookSDK.h>

@interface BrookesRadioFirstViewController : UIViewController{
    MPMoviePlayerController *player;
    
}

@property (strong, nonatomic) UIImageView *imageViews;
@property (nonatomic, retain) MPMoviePlayerController *player;
@property (strong, nonatomic) UIButton *streamButton;
@property (strong, nonatomic) UIImage *streamingImage;

-(IBAction)openActionSheet:(id)sender;

@end
