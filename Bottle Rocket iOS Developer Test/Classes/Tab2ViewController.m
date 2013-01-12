//
//  Tab2ViewController.m
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/11/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "Tab2ViewController.h"
#import "RootViewController.h"

#define UI_TABBAR_HEIGHT 44.0f
#define UI_NAVIGATIONBAR_HEIGHT 44.0f

@interface Tab2ViewController ()

@property (nonatomic , retain) UIToolbar * toolBar;
@end

@implementation Tab2ViewController
@synthesize webView = _webView;
@synthesize toolBar = _toolbar;
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc]initWithFrame:self.navigationController.view.frame];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    
    NSURL * url = [NSURL URLWithString:@"http://www.apple.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.title = @"Web Content";
    [doneButton release];
    
    CGRect frame = self.view.bounds;
    self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0.0f, frame.size.height - UI_TABBAR_HEIGHT - UI_NAVIGATIONBAR_HEIGHT , frame.size.width, UI_TABBAR_HEIGHT)];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(switchWebPage:)];
    
    UIBarButtonItem * forwardItem = [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(switchWebPage:)];
    
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem * stopButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopLoading)];
    stopButton.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem * refreshItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshPage)];
    refreshItem.style = UIBarButtonItemStyleBordered;
    
    [self.toolBar setItems:[NSArray arrayWithObjects:backItem,forwardItem, spaceItem, stopButton,refreshItem, nil]];
    [self.view addSubview:self.toolBar];
    
    [backItem release];
    [forwardItem release];
    [spaceItem release];
    [stopButton release];
    [refreshItem release];
    
}

- (void) viewDidUnload
{
    self.webView = nil;
    self.toolBar = nil;
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    RootViewController * tc = (RootViewController*)self.tabBarController;
    [tc makeTabBarHidden:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    RootViewController * tc = (RootViewController*)self.tabBarController;
    [tc makeTabBarHidden:NO];
}

- (void) dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIBarButtonItem Action

- (void) done
{
    [self.tabBarController setSelectedIndex:0];
}

- (void) switchWebPage:(id)sender
{
    UIBarButtonItem * button = (UIBarButtonItem*)sender;
    if ([button.title isEqualToString:@"Back"])
    {
        if ([self.webView canGoBack])
            [self.webView goBack];
        else return;
    }
    else if ([button.title isEqualToString:@"Next"])
    {
        if ([self.webView canGoForward])
            [self.webView goForward];
        else return;
    }
}

- (void) stopLoading
{
    if ([self.webView isLoading])
        [self.webView stopLoading];
    else return;
}

- (void) refreshPage
{
    [self.webView reload];
}

@end
