//
//  subViewController.m
//  SliderTest
//
//  Created by kyasu on 2014/04/07.
//  Copyright (c) 2014年 kyasu. All rights reserved.
//

#import "subViewController.h"
#import "KYSlideMenuViewController.h"

@interface subViewController() {
}

@end

@implementation subViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%s", __FUNCTION__);
    
    self.navigationItem.title = @"Side B";
    
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

- (IBAction)segment:(id)sender {
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

    // self -> コンテナ
    [(KYSlideMenuViewController *)self.parentViewController slideChildTo:KYS_CLOSE];
}

- (IBAction)viewSlide:(id)sender
{
    // self -> コンテナ
    [(KYSlideMenuViewController *)self.parentViewController slideChildTo:KYS_FLIP];
}

@end
