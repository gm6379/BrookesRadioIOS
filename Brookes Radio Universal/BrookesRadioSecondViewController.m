//
//  BrookesRadioSecondViewController.m
//  Brookes Radio Universal
//
//  Created by george mcdonnell on 17/09/2013.
//  Copyright (c) 2013 george mcdonnell. All rights reserved.
//

#import "BrookesRadioSecondViewController.h"
#import "Reachability.h"
#import <Social/Social.h>



@interface BrookesRadioSecondViewController ()
{
    Reachability *internetReachableFoo;
}
@end



@implementation BrookesRadioSecondViewController

@synthesize actionSheet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"About Us", @"Radio");
        self.tabBarItem.image = [UIImage imageNamed:@"infoicon"];
    }
    return self;
}
UIWebView *webView;
UIToolbar *webViewToolbar;
-(IBAction)scheduleButtonClick:(id)sender{
    webView = [[UIWebView alloc] initWithFrame: self.view.bounds];

    BOOL iPad = NO;
    #ifdef UI_USER_INTERFACE_IDIOM
    iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    #endif
    NSURL *calURL = [NSURL URLWithString:@"https://www.google.com/calendar/embed?mode=agenda&src=9e8fb720qmpg1n7isg23nafq18%40group.calendar.google.com&color=%23BE6D00&ctz=Europe/London"];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;

    if (iPad) {
        calURL = [NSURL URLWithString:@"https://www.google.com/calendar/embed?mode=week&src=9e8fb720qmpg1n7isg23nafq18%40group.calendar.google.com&color=%23BE6D00&ctz=Europe/London"];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:calURL];
        [webView loadRequest:requestObj];
        [self.view addSubview:webView];
        webViewToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,670,screenSize.width+255,44)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(close:)];
        [webViewToolbar setItems:[NSArray arrayWithObjects:flexibleSpace, flexibleSpace, closeButton, nil]];
        
        [self.view addSubview:webViewToolbar];
    }
    else{
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:calURL];
    [webView loadRequest:requestObj];
    [self.view addSubview:webView];
        webViewToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenSize.height-90,screenSize.width,44)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(close:)];
        [webViewToolbar setItems:[NSArray arrayWithObjects:flexibleSpace, flexibleSpace, closeButton, nil]];
        
        [self.view addSubview:webViewToolbar];
    }
    
    
}

- (IBAction)close:(id)sender {
    [webView removeFromSuperview];
    [webViewToolbar removeFromSuperview];
}
-(IBAction)openActionSheet:(id)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email the Studio",@"Facebook Page", @"Twitter Page", @"Share on Facebook", @"Share on Twitter", nil];
    
    [actionSheet showInView:self.view];
}
-(IBAction)getInvolvedButtonClick:(id)sender{
    [self openMailForGetInvolved:nil];
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
    }    //if the share on facebook link is pressed the facebookShare method is ran
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
    
    [self prefersStatusBarHidden];
    
	UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAction) target:self action:@selector(openActionSheet:)];
    
    [self.navigationItem setRightBarButtonItem:barButton animated:NO];
    
    self.actionButton = barButton;

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

-(IBAction)openMailForGetInvolved:(id)sender{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc]init];
        mailer.mailComposeDelegate = self;
        NSArray *toRecipient = [NSArray arrayWithObjects:@"11022129@brookes.ac.uk", nil];
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
