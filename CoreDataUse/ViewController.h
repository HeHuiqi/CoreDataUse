//
//  ViewController.h
//  CoreDataUse
//
//  Created by macpro on 16/3/2.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,strong) AppDelegate *myAppdelegate;


@end

