//
//  MMAppDelegate.h
//  BullsAndCows
//
//  Created by Dilyana Todorova on 12/7/12.
//  Copyright (c) 2012 Dilyana Todorova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
