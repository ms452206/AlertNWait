//
//  ViewController.m
//  AlertNWait
//
//  Created by leodev on 09.03.16.
//  Copyright © 2016 leodev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

    - (void)viewDidAppear:(BOOL)animated {
        
        NSLog(@"Step 1");
        [self alertAndWait];
        NSLog(@"Step 4");
        
        NSLog(@"Step 1");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self alertAndWait];
                 NSLog(@"Step 4");
            });
        });
    }

    - (void)alertAndWait {
            NSLog(@"Step 2");
            __block BOOL ok = NO;
            UIAlertController* myAlert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                             message:@"Please press OK to continue"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* continueAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       ok=YES;
                                                                   }];
            [myAlert addAction:continueAction];
            [self presentViewController:myAlert animated:NO completion:nil];
            while(!ok) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            };
            NSLog(@"Step 3");
    }

@end
