//
//  baseTableViewController.m
//  SliderTest
//
//  Created by kyasu on 2014/04/07.
//  Copyright (c) 2014年 kyasu. All rights reserved.
//

#import "baseTableViewController.h"
#import "KYSlideMenuViewController.h"

@interface baseTableViewController () {
    int   _currentCtrNum;
}

@end

@implementation baseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 最初に表示するビューを設定する
    _currentCtrNum = -1;
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:path];
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Side A";
            break;
        case 1:
            cell.textLabel.text = @"Side B";
            break;
        case 2:
            cell.textLabel.text = @"Side C";
        default:
            break;
    }
    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (int i = 0 ; i < [tableView numberOfRowsInSection:0] ; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
        if (i == indexPath.row) {
            cell.textLabel.textColor = [UIColor whiteColor];
        } else {
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }

    // 現在のビューコントローラなら表示するだけ
    if (_currentCtrNum == indexPath.row) {
        [(KYSlideMenuViewController *)self.parentViewController slideChildTo:KYS_CLOSE];
        return;
    }
    _currentCtrNum = (int)indexPath.row;
    
    // 新しいビューコントローラを生成してコンテナのビューコントローラを入れ替え
    UIViewController *toCtr;
    switch (indexPath.row) {
        case 0: // navigationあり
            toCtr = [[self storyboard] instantiateViewControllerWithIdentifier:@"mainView"];
            break;
        case 1: // navigationなし
            toCtr = [[self storyboard] instantiateViewControllerWithIdentifier:@"subView"];
            break;
        case 2: // navigationあり
            toCtr = [[self storyboard] instantiateViewControllerWithIdentifier:@"srdView"];
            break;
        default:
            return;
    }
    [(KYSlideMenuViewController *)self.parentViewController changeTo:toCtr];
}

@end
