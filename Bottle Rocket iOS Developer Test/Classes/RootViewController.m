//
//  RootViewController.m
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/11/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "RootViewController.h"
#import "Tab1TableViewController.h"
#import "Tab2ViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    
    Tab1TableViewController * vc1 = [[Tab1TableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController * nc1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    UITabBarItem * tabBarItem1 = [[UITabBarItem alloc]initWithTitle:@"TableView" image:nil tag:0];
    [nc1 setTabBarItem:tabBarItem1];
    [vc1 release];
    
    Tab2ViewController * vc2 = [[Tab2ViewController alloc]init];
    UINavigationController * nc2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    UITabBarItem * tabBarItem2 = [[UITabBarItem alloc]initWithTitle:@"WebView" image:nil tag:1];
    [nc2 setTabBarItem:tabBarItem2];
    [vc2 release];
    
    self.viewControllers = [NSArray arrayWithObjects:nc1, nc2, nil];
    self.selectedIndex = 1;

    [nc1 release];
    [nc2 release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -

-(void)makeTabBarHidden:(BOOL)hide
{
    // Custom code to hide TabBar
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    
    if (hide)
        contentView.frame = self.view.bounds;
    
    self.tabBar.hidden = hide;
    UIButton * button = (UIButton*)[self.view viewWithTag:3059];
    button.enabled = hide ? NO:YES;
    
}

#pragma mark - UITabBarControllerDelegate

- (BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}



@end
