//
//  ViewController.m
//  SliderTest
//
//  Created by kyasu on 2014/04/07.
//  Copyright (c) 2014年 kyasu. All rights reserved.
//

#import "KYSSlideMenuViewController.h"

@interface KYSSlideMenuViewController () {
    float _prevPosX;
}

@property (nonatomic, strong) UIPanGestureRecognizer *grP;
@property (nonatomic, strong) UITapGestureRecognizer *grT;

@end

@implementation KYSSlideMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ジェスチャー作成
    self.grP = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panChild:)];
    self.grT = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChild:)];

    // 最初のビューを表示するためのダミーを設定しておく
    UIViewController *dummyVC = [[UIViewController alloc] init];
    [self addChildViewController:dummyVC];
    [self.containerView addSubview:dummyVC.view];
}

// コンテナに乗せるビューコントローラを変更
- (void)changeTo:(UIViewController *)toCtr
{
    // 現在のビューコントローラ
    UIViewController *fromCtr = [self.childViewControllers lastObject];
    // 新しいビューコントローラをコンテナに追加
    [self addChildViewController:toCtr];
    // ビューコントローラを入れ替え
    [self transitionFromViewController:fromCtr
                      toViewController:toCtr
                              duration:0.0
                               options:0
                            animations:^{
                                ;   // この間がないとnavigationBarの描画が見えてしまう
                            } completion:^(BOOL finished) {
                                // close
                                CGRect rect = _containerView.frame;
                                rect.origin.x = 0;
                                [UIView animateWithDuration:0.5
                                                      delay:0
                                     usingSpringWithDamping:1.0
                                      initialSpringVelocity:0.5
                                                    options:UIViewAnimationOptionCurveLinear
                                                 animations:^{
                                                     _containerView.frame = rect;
                                                 }
                                                 completion:^(BOOL finished) {
                                                     // 以前のビューをコンテナから外す
                                                     [fromCtr removeFromParentViewController];
                                                 }
                                 ];
                            }
     ];
}

// リストビューの表示・非表示
- (void)slideChildTo:(int)dirction
{
    CGRect rect = _containerView.frame;
    
    // KYS_FLIPの時はコンテナビューの位置で決定する
    if (dirction == KYS_FLIP) {
        if (rect.origin.x == 0) {
            dirction = KYS_OPEN;
        } else {
            dirction = KYS_CLOSE;
        }
    }
    
    UIViewController *curCtr = [self.childViewControllers lastObject];
    
    // （何度もくるので）コンテナビューの前のジェスチャーを削除してから
    [_containerView removeGestureRecognizer:_grP];
    [_containerView removeGestureRecognizer:_grT];
    
    if (dirction == KYS_OPEN) {
        // コンテナビューにジェスチャーを設定する
        [_containerView addGestureRecognizer:_grP];
        [_containerView addGestureRecognizer:_grT];
        // childViewのタップへの反応をさせない
        curCtr.view.userInteractionEnabled = NO;
        // リストビューを表示する
        rect.origin.x = KYS_DROWER_MAX;
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.75
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             _containerView.frame = rect;
                         }
                         completion:nil
         ];
    } else {
        // childViewのタップへの反応を許す
        curCtr.view.userInteractionEnabled = YES;
        // リストビューを非表示にする
        rect.origin.x = 0;
        [UIView animateWithDuration:0.4
                              delay:0
             usingSpringWithDamping:1.0
              initialSpringVelocity:0.1
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             _containerView.frame = rect;
                         }
                         completion:nil
         ];
    }
}

// タップでクローズ
- (void)tapChild:(UITapGestureRecognizer *)gr
{
    [self slideChildTo:KYS_CLOSE];
}

// ドラッグ
- (void)panChild:(UIPanGestureRecognizer *)gr
{
    CGPoint location = [gr translationInView:self.view];
    CGPoint velocity = [gr velocityInView:self.view];
    CGRect  cRect    = self.containerView.frame;
    
    switch (gr.state) {
        case UIGestureRecognizerStateBegan:
            // ドラッグし始めの位置
            _prevPosX = location.x;
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (velocity.x < 0) {
                // ←ならクローズ
                [self slideChildTo:KYS_CLOSE];
            } else {
                // →ならオープン
                [self slideChildTo:KYS_OPEN];
            }
            break;
        default:
            // 前回の位置との差分でコンテナビューを移動
            cRect.origin.x += (location.x - _prevPosX);
            if (0 <= cRect.origin.x && cRect.origin.x <= KYS_DROWER_MAX) {
                self.containerView.frame = cRect;
            }
            _prevPosX = location.x;
            break;
    }
}

@end
