//
//  Created by Diyuan Wang on 2019/11/21.
//  Copyright © 2019年 Diyuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumApiBaseViewController.h"


@interface BBSShowPrivateMessageViewController : ForumApiBaseViewController


@property(nonatomic, strong) NSMutableArray<ViewMessagePage *> *dataList;


- (IBAction)back:(id)sender;

@property(weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)replyPM:(id)sender;

@end
