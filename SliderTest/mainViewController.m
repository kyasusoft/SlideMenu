//
//  mainViewController.m
//  SliderTest
//
//  Created by kyasu on 2014/04/07.
//  Copyright (c) 2014年 kyasu. All rights reserved.
//

#import "mainViewController.h"
#import "KYSlideMenuViewController.h"

@interface mainViewController() {
}

@end

@implementation mainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%s", __FUNCTION__);
    
    self.navigationItem.title = @"Side A";
    
    // navigationBarにボタンを追加
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"waveLine"]
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:@selector(viewSlide:)];
    self.navigationItem.leftBarButtonItem = barBtn;
 }

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark -

- (IBAction)button:(id)sender {
    // 色替え
    float r = arc4random() % 100 / 100.0;
    float g = arc4random() % 100 / 100.0;
    float b = arc4random() % 100 / 100.0;
    self.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

#pragma mark - Slide view

- (void)willMoveToParentViewController:(UIViewController *)parent
{
//    NSLog(@"%s", __FUNCTION__);
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
//    NSLog(@"%s", __FUNCTION__);

    // self -> ナビゲーション -> コンテナ
    [(KYSlideMenuViewController *)self.parentViewController.parentViewController slideChildTo:KYS_CLOSE];
}

- (IBAction)viewSlide:(id)sender
{
    // self -> ナビゲーション -> コンテナ
    [(KYSlideMenuViewController *)self.parentViewController.parentViewController slideChildTo:KYS_FLIP];
}

@end
