//
//  MMMainViewController.h
//  BullsAndCows
//
//  Created by Dilyana Todorova on 12/7/12.
//  Copyright (c) 2012 Dilyana Todorova. All rights reserved.
//

#import "MMFlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MMMainViewController : UIViewController <MMFlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
