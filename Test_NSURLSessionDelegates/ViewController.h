//
//  ViewController.h
//  Test_NSURLSessionDelegates
//
//  Created by Eduardo Flores on 3/25/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSURLSessionDownloadDelegate>


@property (weak, nonatomic) IBOutlet UILabel *label_downloadURL;
@property (weak, nonatomic) IBOutlet UILabel *label_bytesExpected;
@property (weak, nonatomic) IBOutlet UILabel *label_bytesWritten;
@property (weak, nonatomic) IBOutlet UILabel *label_savedLocation;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

