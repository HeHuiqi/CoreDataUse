//
//  ViewController.m
//  CoreDataUse
//
//  Created by macpro on 16/3/2.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "ViewController.h"
#import "Book.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myAppdelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"插入",@"删除",@"更新",@"查询"]];
    segmentControl.frame = CGRectMake(20, 80, self.view.bounds.size.width-40, 30);
    [self.view addSubview:segmentControl];
    
    [segmentControl addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    
}
- (void)changeValue:(UISegmentedControl *)segmentContol{
    switch (segmentContol.selectedSegmentIndex) {
        case 0:
        {
            [self insertData:nil];
        }
            break;
        case 1:
        {
            [self deleteData:nil];

        }
            break;
        case 2:
        {
            [self updateData:nil];
        }
            break;
        case 3:
        {
            [self queryData:nil];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 插入
- (void)insertData:(id)data
{
    Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:_myAppdelegate.managedObjectContext];
    book.name = @"软件开发";
    book.price = [NSNumber numberWithFloat:10.5];
    
    NSError *error = nil;
    
    BOOL isSaveSuccess = [_myAppdelegate.managedObjectContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error:%@",error);
    }else{
        NSLog(@"Save successful!");
    }
    
}
#pragma mark - 查询
- (void)queryData:(id)data
{

    NSError *error = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Book"];
    
    NSMutableArray *resultArray = [[_myAppdelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (resultArray == nil) {
        NSLog(@"error = %@",error);
    }else{
        NSLog(@"query successful!");
    }
    
    for (Book *book in resultArray) {
        NSLog(@"name==%@------price==%@\n",book.name,book.price);
    }
}
#pragma mark - 更新
- (void)updateData:(id)data
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *book = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:_myAppdelegate.managedObjectContext];
    request.entity = book;
    //条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==%@",@"软件开发"];
    request.predicate = predicate;
    
    NSError *error = nil;
    
    NSMutableArray *fetchResult = [[_myAppdelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (fetchResult == nil) {
        NSLog(@"Error= %@",error);
    }else{
        NSLog(@"update successful!");
    }
    
    for (Book *book in fetchResult) {
        book.name = @"我的青春";
    }
    [_myAppdelegate.managedObjectContext save:&error];
    
}
#pragma mark - 删除
- (void)deleteData:(id)date
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *book = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:_myAppdelegate.managedObjectContext];
    request.entity = book;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==%@",@"我的青春"];
    request.predicate = predicate;
    
    NSError *error = nil;
    
    NSMutableArray *fetchResult = [[_myAppdelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (fetchResult == nil) {
        NSLog(@"delete error = %@",error);
    }else{
        NSLog(@"delete successful!");
    }
    for (Book *book in fetchResult) {
        [_myAppdelegate.managedObjectContext deleteObject:book];
    }
    if (![_myAppdelegate.managedObjectContext save:&error]) {
        NSLog(@"Error == %@,%@",error,error.userInfo);
    }else{
        NSLog(@"delete save successful !");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
