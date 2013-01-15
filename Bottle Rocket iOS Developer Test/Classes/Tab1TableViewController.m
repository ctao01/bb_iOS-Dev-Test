//
//  Tab1TableViewController.m
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/11/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import "Tab1TableViewController.h"

#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "JSONKit.h"

#import "CustomTableViewCell.h"
#import "DetailViewController.h"

@interface Tab1TableViewController ()
@property (nonatomic ,retain) NSArray * collections;
@property (nonatomic ,retain) NSMutableData * data;

@end

@implementation Tab1TableViewController
@synthesize collections = _collections;
@synthesize data = _data;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"Store Data";
    
    NSURL * url = [NSURL URLWithString:@"http://strong-earth-32.heroku.com/stores.aspx"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
//    dispatch_async(queue, ^{
//        NSURLResponse *response = nil;
//        NSError *error = nil;
//        
//        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request
//                                                     returningResponse:&response
//                                                                 error:&error];
//        
//        //json parse
//        NSString * responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
//        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//        //Accessing JSON content
//        NSLog(@"type :  %@", [jsonObject objectForKey:@"Type"] );

//        [self processJSONDataWithReceivedData:receivedData andError:error];
        
//        if ([receivedData length] >0 && error == nil)
//        {
//            id result = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:&error];
//            if (error == nil)
////                dispatch_async(dispatch_get_main_queue(), ^{
//                    self.collections = [[NSMutableArray alloc]initWithArray:[result objectForKey:@"stores"]];
//                    [self.tableView reloadData];
////                    [activityIndicator stopAnimating];
//                    
//                    
////                });
//        }
//        else if ([receivedData length] == 0 && error == nil)
//        {
//            NSLog(@"Nothing was downloaded.");
//        }
//        else if (error != nil){
//            NSLog(@"Error = %@", error);
//        }

//    });
    
//    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityIndicator.center = CGPointMake(self.view.center.x, self.view.center.y - 44.0f);
//    [self.view addSubview:activityIndicator];
//    [activityIndicator startAnimating];
    
//    [BCURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data,NSError *error)
//     {
//         if ([data length] >0 && error == nil)
//         {
//             id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//             if (error == nil)
//             dispatch_async(dispatch_get_main_queue(), ^{
//                 self.collections = [[NSMutableArray alloc]initWithArray:[result objectForKey:@"stores"]];
//                 [self.tableView reloadData];
//                 [activityIndicator stopAnimating];
//
//
//             });
//         }
//         else if ([data length] == 0 && error == nil)
//         {
//             NSLog(@"Nothing was downloaded.");
//         }
//         else if (error != nil){
//             NSLog(@"Error = %@", error);
//         }
//
//     }];
//    [activityIndicator release];

}

- (void) dealloc
{
    [self.collections release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 

-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response
{
    _data = [[NSMutableData alloc] init]; // _data being an ivar
    NSLog(@"%@",_data);
}
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [_data appendData:data];
    NSLog(@"%@",data);
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    id result = [self.data objectFromJSONData];

    self.collections = [[NSMutableArray alloc]initWithArray:[result objectForKey:@"stores"]];
    NSLog(@"%@",self.collections);

    [self.tableView reloadData];
    
    [connection release];

}

#pragma mark -

//- (void) processJSONDataWithReceivedData:(NSData*)data andError:(NSError*)error
//{
//    NSLog(@"processJSONDataWithReceivedData");
//    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//    NSLog(@"%@",result);
//}

- (UIImage *) imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    return [self.collections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (CustomTableViewCell*)[[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.phoneLabel.text = [[self.collections objectAtIndex:indexPath.row] objectForKey:@"phone"];
    cell.addressLabel.text = [[self.collections objectAtIndex:indexPath.row] objectForKey:@"address"];
    NSURL * url = [NSURL URLWithString:[[self.collections objectAtIndex:indexPath.row] objectForKey:@"storeLogoURL"]];
    NSLog(@"%@",url);

    if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
        [cell.logoImageView setImageWithURL:url  placeholderImage:nil];
    
    else
        [cell.logoImageView setImageWithURL:url placeholderImage:nil options:SDWebImageLazyLoad];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString * cellText =[[self.collections objectAtIndex:indexPath.row] objectForKey:@"phone"];
//    UIFont *cellFont = [UIFont fontWithName:@"ArialMT" size:16.0];
//    CGSize constraintSize = CGSizeMake(100, MAXFLOAT);
//    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    NSURL * url = [NSURL URLWithString:[[self.collections objectAtIndex:indexPath.row] objectForKey:@"storeLogoURL"]];
    UIImage * logoImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    return logoImage.size.height + 40.0f;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * vc = [[DetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    vc.title = [[self.collections objectAtIndex:indexPath.row] objectForKey:@"name"];
    [vc setSelectedObject:[self.collections objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark -
#pragma mark Table cell image support

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([self.collections count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            CustomTableViewCell *cell = (CustomTableViewCell*) [[self tableView] cellForRowAtIndexPath:indexPath];
            [cell.logoImageView startDownloadWithOptions:SDWebImageLazyLoad];
        }
    }
}

#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}


@end
