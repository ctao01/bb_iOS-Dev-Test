//
//  NSURLConnection+Additions.m
//  Bottle Rocket iOS Developer Test
//
//  Created by Joy Tao on 1/15/13.
//  Copyright (c) 2013 Joy Tao. All rights reserved.
//
#import <objc/runtime.h>
#import "NSURLConnection+Additions.h"

typedef void (^BCCallbackBlock)(NSURLResponse*, NSData*, NSError*);

@interface URLConnectionHandler : NSObject <NSURLConnectionDelegate>

@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) BCCallbackBlock handler;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSURLResponse *response;

@end

@implementation URLConnectionHandler
@synthesize connection, handler = _handler, queue = _queue, data = _data, response = _response;

- (void)performRequest:(NSURLRequest *)request queue:(NSOperationQueue *)queue completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler {
    self.handler = handler;
    
    if (!queue) queue = [NSOperationQueue mainQueue];
    self.queue = queue;
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    BCCallbackBlock handler = self.handler;
    self.handler = nil;
    
    NSURLResponse *response = self.response;
    [self.queue addOperationWithBlock:^{
        handler(response, nil, error);
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (response.expectedContentLength > 0) {
        self.data = [NSMutableData dataWithCapacity:response.expectedContentLength];
    } else {
        self.data = [NSMutableData data];
    }
    
    self.response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    BCCallbackBlock handler = self.handler;
    self.handler = nil;
    
    NSURLResponse *response = self.response;
    NSData *data = [self.data copy];
    
    [self.queue addOperationWithBlock:^{
        handler(response, data, nil);
    }];
}

@end

@implementation NSURLConnection (Additions)

+ (void)sendAsynchronousRequest:(NSURLRequest *)request queue:(NSOperationQueue *)queue completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler {
    
    if (class_getClassMethod([self superclass], @selector(sendAsynchronousRequest:queue:completionHandler:)) != NULL) {
        [super sendAsynchronousRequest:request queue:queue completionHandler:handler];
    } else {
        URLConnectionHandler *connectionHandler = [[URLConnectionHandler alloc] init];
        [connectionHandler performRequest:request queue:queue completionHandler:handler];
    }
}
@end
