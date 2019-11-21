//
//  DiscuzMessageTableViewController.h
//  Created by Diyuan Wang on 2019/11/21.
//  Copyright © 2019年 Diyuan Wang. All rights reserved.
//

#import "ForumApiBaseTableViewController.h"

@interface DiscuzMessageTableViewController : ForumApiBaseTableViewController

- (IBAction)showLeftDrawer:(id)sender;

@property(weak, nonatomic) IBOutlet UISegmentedControl *messageSegmentedControl;

- (IBAction)writePrivateMessage:(UIBarButtonItem *)sender;

@property(weak, nonatomic) IBOutlet UIBarButtonItem *leftMenu;


@end
