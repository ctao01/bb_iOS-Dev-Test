//
//  NSURLConnection+Additions.h
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/15/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLConnection (Additions)

+ (void)sendAsynchronousRequest:(NSURLRequest *)request queue:(NSOperationQueue *)queue completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler;

@end
