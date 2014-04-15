//
//  baseTableViewController.h
//  SliderTest
//
//  Created by kyasu on 2014/04/07.
//  Copyright (c) 2014年 kyasu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baseTableViewController : UIViewController
<
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
