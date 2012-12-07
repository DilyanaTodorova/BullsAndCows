//
//  MMFlipsideViewController.m
//  BullsAndCows
//
//  Created by Dilyana Todorova on 12/7/12.
//  Copyright (c) 2012 Dilyana Todorova. All rights reserved.
//

#import "MMFlipsideViewController.h"

@interface MMFlipsideViewController ()

@end

@implementation MMFlipsideViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
