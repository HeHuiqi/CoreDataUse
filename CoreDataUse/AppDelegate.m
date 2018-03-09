//
//  AppDelegate.m
//  CoreDataUse
//
//  Created by macpro on 16/3/2.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;

- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        
        return _managedObjectContext;
    }
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    //打开模型文件，参数为nil则打开包中所有模型文件并合并成一个
  
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];

    //创建数据解析器
    NSPersistentStoreCoordinator *storeCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    //创建数据库保存路径
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES).firstObject;
    NSString *path = [dir stringByAppendingPathComponent:@"myDatabase.db"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSLog(@"path = %@",path);
    //添加SQLite持久存储到解析器
    NSError *error;
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil
                                             URL:url
                                         options:nil
                                           error:&error];
    
    NSManagedObjectContext *context = nil;
    if( !error ){
        //创建对象管理上下文，并设置数据解析器
        context = [[NSManagedObjectContext alloc] init];
        context.persistentStoreCoordinator = storeCoordinator;
        NSLog(@"数据库打开成功！");
    }else{
        NSLog(@"数据库打开失败！错误:%@",error.localizedDescription);
    }
    _managedObjectContext = context;
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark - 创建 NSManagedObjectContext
- (NSManagedObjectContext *)creatManagedObjectContext
{
    //1、创建模型对象
    //获取模型路径
    //modelName 模型名字（带xcdatamodeld后缀的名字）
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"modelName" withExtension:@"momd"];
    //根据模型文件创建模型对象
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    //2、创建持久化助理    //利用模型对象创建助理对象
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    //数据库的名称和路径
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"mySqlite.sqlite"];    NSLog(@"path = %@", sqlPath);
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    //设置数据库相关信息
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:nil];
    //3、创建上下文
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    //关联持久化助理
    context.persistentStoreCoordinator = store;
    
    return context;
    
}


@end
