//
//  MMFlipsideViewController.h
//  BullsAndCows
//
//  Created by Dilyana Todorova on 12/7/12.
//  Copyright (c) 2012 Dilyana Todorova. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMFlipsideViewController;

@protocol MMFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(MMFlipsideViewController *)controller;
@end

@interface MMFlipsideViewController : UIViewController

@property (weak, nonatomic) id <MMFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
