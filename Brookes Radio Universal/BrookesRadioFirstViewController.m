//
//  BrookesRadioFirstViewController.m
//  Brookes Radio Universal
//
//  Created by george mcdonnell on 17/09/2013.
//  Copyright (c) 2013 george mcdonnell. All rights reserved.
//

#import "BrookesRadioFirstViewController.h"
#import "Reachability.h"
#import <Social/Social.h>
#include <arpa/inet.h>

@interface BrookesRadioFirstViewController ()
{
    Reachability *internetReachableFoo;
}
@end

@implementation BrookesRadioFirstViewController;

@synthesize imageViews;
@synthesize player;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Radio", @"Radio");
        self.tabBarItem.image = [UIImage imageNamed:@"radio"];
    }
    return self;
}

-(IBAction)openActionSheet:(id)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email the Studio",@"Facebook Page", @"Twitter Page", @"Share on Facebook", @"Share on Twitter", nil];
    
    
    [actionSheet showInView:self.view];
}


-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSURL *facebookPageURL = [NSURL URLWithString:@"fb://profile/293287194023031"];
    NSURL *twitterPageURL = [NSURL URLWithString:@"twitter://user?screen_name=BrookesRadio"];
    //if send e-mail button is selected: opens mail compose view controller to send message
    if(buttonIndex == 0){
        [self openMailForDJ:nil];
    }
    //if the facebook page button is selected, the facebook application will open and open the facebook page
    else if(buttonIndex == 1){
        if ([[UIApplication sharedApplication] canOpenURL:facebookPageURL]){
        [[UIApplication sharedApplication]
         openURL:facebookPageURL];
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/brookesradio?red=ts&fref=ts)"]];
        }
    }
    //if the twitter page button is selected the twitter application opens and opens the brookes radio page
    else if(buttonIndex == 2){
        if ([[UIApplication sharedApplication] canOpenURL:twitterPageURL]){
            [[UIApplication sharedApplication]
             openURL:twitterPageURL];
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/BrookesRadio"]];
        }
    }
    //if the share on facebook link is pressed the facebookShare method is ran
    else if (buttonIndex == 3){
        [self facebookShare];
    }
    //if the share on twitter link is pressed the twitterShare method is ran
    else if(buttonIndex == 4){
        [self twitterShare];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self testInternetConnection];
    
    [self prefersStatusBarHidden];
    
    //initialises a movie player controller and the stream url for brookes radio
    //If Brookes radio isn't online use bbc.co.uk/radio/listen/live/r1.pls to test the stream
    NSURL *streamURL = [NSURL URLWithString:@"http://s1.freeshoutcast.com:48266/listen.pls"];
    player = [[MPMoviePlayerController alloc]initWithContentURL:streamURL];
    player.movieSourceType = MPMovieSourceTypeStreaming;
    player.view.frame = CGRectMake(55, 180, 200, 30);
    player.backgroundView.backgroundColor = [UIColor clearColor];
    
    UIImage *initialImage = [UIImage imageNamed:@"notStreaming.png"];
    UIButton *streamButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    
    //creates a new image view containing the initial image
    self.imageViews = [[UIImageView alloc] initWithImage: initialImage];
    
    BOOL iPad = NO;
    #ifdef UI_USER_INTERFACE_IDIOM
    iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    #endif
    if (iPad) {
        // iPad specific code here
        CGRect imageFrame = CGRectMake(10.0f, 10.0f, self.imageViews.frame.size.width, self.imageViews.frame.size.height/1.75);
        [self.imageViews setFrame:imageFrame];
        
        [self.imageViews setContentMode: UIViewContentModeScaleAspectFit];
        self.imageViews.center = CGPointMake(520.0f, 325.0f);
        
        streamButton.frame = CGRectMake(360.0f, 600.0f, 300.0f, 37.0f);
        [streamButton setTitle:@"LISTEN LIVE" forState: UIControlStateNormal];
        streamButton.titleLabel.font = [UIFont systemFontOfSize:26.0];
    
        [streamButton addTarget: self action:@selector(streamButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    } else {
        // iPhone/iPod specific code here
        CGRect imageFrame = CGRectMake(10.0f, 10.0f, self.imageViews.frame.size.width, self.imageViews.frame.size.height/4);
        [self.imageViews setFrame:imageFrame];
        
        [self.imageViews setContentMode: UIViewContentModeScaleAspectFit];
        self.imageViews.center = CGPointMake(160.0f, 200.0f);
        
        streamButton.frame = CGRectMake(85.0f, 325.0f, 150.0f, 37.0f);
        [streamButton setTitle:@"LISTEN LIVE" forState: UIControlStateNormal];
        [streamButton addTarget: self action:@selector(streamButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    //add the image view to the current view
    [self.view addSubview:self.imageViews];

    //add the stream button to the current view
    [self.view addSubview:streamButton];
    
}

//tests whether there is an internet connection available
-(void)testInternetConnection
{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability *reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"There is an internet connection available");
        });
    };
    
    //An error message is shown if the Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability *reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"There is no internet connection available");
            UIAlertView *noInternetAlert = [[UIAlertView alloc] initWithTitle: @"Connection Error"message:@"You are not connected to the internet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [noInternetAlert show];
        });
    };
    
    [internetReachableFoo startNotifier];
    
}

-(void) streamButtonClick:(UIButton *)paramSender{
    /* When the stream button is clicked if the stream button text is "LISTEN LIVE", the text on the button changes to "STOP" and the stream begins from the brookes radio server, the not streaming image then flips to the streaming image
     
     When the stream is selected to "STOP" the streaming image then flips back to the not streaming image and the stream is stopped, the button text changes to LISTEN LIVE
     
     */
    UIButton *streamButton = paramSender;
    
    if([streamButton.currentTitle isEqualToString:@"LISTEN LIVE"]){
        NSLog(@"Clicked on the button");
        
        UIImage *streamingImage = [UIImage imageNamed:@"streaming.png"];
        
        [UIView transitionWithView:self.imageViews duration: 2.5 options:
         UIViewAnimationOptionTransitionFlipFromRight animations:^
         {completion:self.imageViews.image = streamingImage;
         } completion:nil];
        
        [streamButton setTitle: @"STOP" forState:UIControlStateNormal];
        [streamButton setTitleColor:([UIColor redColor]) forState:(UIControlStateNormal)];
        
        [player prepareToPlay];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        
        NSError *setCategoryError = nil;
        
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
        
        if (setCategoryError) {
            NSLog(@"Audiosession error: %@", setCategoryError.description);
        }
        
        NSError *activationError = nil;
        
        [audioSession setActive:YES error:&activationError];
        
        if(activationError){
            NSLog(@"Audiosession error: %@", activationError.description);
        }
        
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        
        [player play];
        
    }
    
    else if([streamButton.currentTitle isEqualToString:@"STOP"]){
        UIImage *streamingImage = [UIImage imageNamed:@"notStreaming.png"];
        
        [UIView transitionWithView:self.imageViews duration: 2.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^
         {completion:self.imageViews.image = streamingImage;
         }completion:nil];
        
        [streamButton setTitle: @"LISTEN LIVE" forState:UIControlStateNormal];
        [streamButton setTitleColor:([UIColor colorWithRed:50.0/255.0 green:79.0/255.0 blue:133.0/255.0 alpha:1]) forState:(UIControlStateNormal)];
        
        [player stop];
    }
}

-(void)facebookShare
/* Opens the facebook app if it is available, and sets up a share dialog with an image from Brookes radio and a link to the Brookes radio site
If the facebook app isn't available, then the user is redirected to safari
*/
{
    [FBSession openActiveSessionWithReadPermissions:@[@"basic_info", @"email"]
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState status,
                                                      NSError *error) {
                                      // Respond to session state changes,
                                      // ex: updating the view
                                  }];
    
    //Setup the dialog parameters
    FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
    params.link = [NSURL URLWithString:@"http://brookesradio.com"];
    params.picture = [NSURL URLWithString: @"http://gdurl.com/ujvq"];
    params.name = @"Brookes Radio";
    params.caption = @"Oxford Brookes Student Radio";
    params.description = @"Oxford brookes radio is run solely by students for students, our main aim is to share entertainment and information amongst students and to provide everyone at Oxford Brookes University with a platform from which they can make their voice heard.";
    [FBDialogs presentShareDialogWithParams:params
                                clientState:nil
                                    handler:
     ^(FBAppCall *call, NSDictionary *results, NSError *error) {
         if(error) {
             NSLog(@"Error: %@", error.description);
         }
         else {
             NSLog(@"Success");
         }
     }];
}

-(void)twitterShare
/* Opens the twitter share sheet and initialises with some text related to brookes radio,
if the user does not have a twitter account, then an error is shown
*/
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Listening to @BrookesRadio :)"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}

-(IBAction)openMailForDJ:(id)sender{
    //Opens the mail view controller and fills the recipient with the brookes dj e-mail address
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc]init];
        mailer.mailComposeDelegate = self;
        NSArray *toRecipient = [NSArray arrayWithObjects:@"djs@brookesradio.com", nil];
        [mailer setToRecipients:toRecipient];
        [self presentViewController:mailer animated:YES completion:nil];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"Your device doesn't support the composer sheet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
