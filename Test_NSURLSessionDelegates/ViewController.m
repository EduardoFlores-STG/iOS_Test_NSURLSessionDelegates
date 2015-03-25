//
//  ViewController.m
//  Test_NSURLSessionDelegates
//
//  Created by Eduardo Flores on 3/25/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "ViewController.h"

#define URL_LARGE_IMAGE_1   @"http://edmullen.net/test/rc.jpg"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.allowsCellularAccess = NO;
    
    // Other options for configuration, if needed. I dont need them for this test
//    [configuration setHTTPAdditionalHeaders:some dictionary values];
//    configuration.timeoutIntervalForRequest = 30.0;
//    configuration.timeoutIntervalForResource = 60.0;
//    configuration.HTTPMaximumConnectionsPerHost = 1;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self
                                                     delegateQueue:nil];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:URL_LARGE_IMAGE_1]];
    [task resume];
    
    self.label_downloadURL.text = [NSString stringWithFormat:@"URL = %@", URL_LARGE_IMAGE_1];
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSData *imageData = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(),
       ^{
           self.label_savedLocation.text = [NSString stringWithFormat:@"%@", location];   // too much text for 1 label
           self.imageView.image = [UIImage imageWithData:imageData];
       });
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    long percentage = (totalBytesWritten * 100) / totalBytesExpectedToWrite;
    
    dispatch_async(dispatch_get_main_queue(),
       ^{
           self.label_bytesExpected.text = [NSString stringWithFormat:@"Expected = %lld", totalBytesExpectedToWrite];
           self.label_bytesWritten.text = [NSString stringWithFormat:@"Received = %lld (%ld%%)", totalBytesWritten, percentage];
       });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end









































