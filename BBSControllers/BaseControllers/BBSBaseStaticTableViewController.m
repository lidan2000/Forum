//
//  Created by Diyuan Wang on 2019/11/21.
//  Copyright © 2019年 Diyuan Wang. All rights reserved.
//

#import "BBSBaseStaticTableViewController.h"
#import "BBSLocalApi.h"

@interface BBSBaseStaticTableViewController () {
    BOOL disablePullrefresh;

    BOOL disableLoadMore;
}

@end

@implementation BBSBaseStaticTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 97.0;

    if ([self setPullRefresh:YES]) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self onPullRefresh];
        }];

        if ([self autoPullfresh]) {
            [self.tableView.mj_header beginRefreshing];
        }
    }


    if ([self setLoadMore:YES]) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self onLoadMore];
        }];
    }


}

- (void)onPullRefresh {

}

- (void)onLoadMore {

}

- (BOOL)autoPullfresh {
    return YES;
}

- (NSString *)currentForumHost {

    BBSLocalApi *localForumApi = [[BBSLocalApi alloc] init];
    NSString *urlStr = [localForumApi currentForumURL];
    NSURL *url = [NSURL URLWithString:urlStr];
    return url.host;
}


- (BOOL)setPullRefresh:(BOOL)enable {
    return YES;
}

- (BOOL)setLoadMore:(BOOL)enable {
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

#pragma mark initData

- (void)initData {
    BBSLocalApi *localForumApi = [[BBSLocalApi alloc] init];
    self.forumApi = [BBSApiHelper forumApi:localForumApi.currentForumHost];
    self.dataList = [[NSMutableArray alloc] init];
}


#pragma mark override-init

- (instancetype)init {
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

#pragma mark overide-initWithCoder

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initData];
    }
    return self;
}

#pragma mark overide-initWithName

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initData];
    }
    return self;
}

#pragma mark overide-initWithStyle

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        [self initData];
    }
    return self;
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

@end
