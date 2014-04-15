//
//  ViewController.h
//  SliderTest
//
//  Created by kyasu on 2014/04/07.
//  Copyright (c) 2014年 kyasu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KYS_DROWER_MAX 255
#define KYS_FLIP  0
#define KYS_OPEN  1
#define KYS_CLOSE 2

@interface KYSlideMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;

- (void)changeTo:(UIViewController *)toCtr;
- (void)slideChildTo:(int)diretion;

@end
