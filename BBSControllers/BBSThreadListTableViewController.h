//
//  Created by Diyuan Wang on 2019/11/21.
//  Copyright © 2019年 Diyuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSApiBaseTableViewController.h"


@interface BBSThreadListTableViewController : BBSApiBaseTableViewController


// 置顶
@property(nonatomic, strong) NSMutableArray *threadTopList;

- (IBAction)back:(UIBarButtonItem *)sender;


- (IBAction)createThread:(id)sender;


@property(weak, nonatomic) IBOutlet UINavigationItem *titleNavigationItem;

@end
