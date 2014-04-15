//
//  subViewController.m
//  SliderTest
//
//  Created by kyasu on 2014/04/07.
//  Copyright (c) 2014年 kyasu. All rights reserved.
//

#import "srdViewController.h"
#import "KYSlideMenuViewController.h"

@interface srdViewController() {
}

@end

@implementation srdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%s", __FUNCTION__);

    self.navigationItem.title = @"Side C";

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

- (IBAction)slider:(id)sender {
    // 色替え
    float f = ((UISlider *)sender).value;
    CGFloat r, g, b, a;
    [self.view.backgroundColor getRed:&r green:&g blue:&b alpha:&a];
    self.view.backgroundColor = [UIColor colorWithRed:r green:f blue:b alpha:a];
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
