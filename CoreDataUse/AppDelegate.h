//
//  AppDelegate.h
//  CoreDataUse
//
//  Created by macpro on 16/3/2.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;


@end

