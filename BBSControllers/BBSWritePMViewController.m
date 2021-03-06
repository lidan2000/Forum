
//
//  Created by Diyuan Wang on 2019/11/21.
//  Copyright © 2019年 Diyuan Wang. All rights reserved.
//

#import "BBSWritePMViewController.h"
#import "BBSPayManager.h"
#import "BBSLocalApi.h"
#import "UIStoryboard+Forum.h"
#import "ProgressDialog.h"


@interface BBSWritePMViewController () <TranslateDataDelegate> {
    UserCount *_toUser;
    BOOL isReply;
    BBSLocalApi *_localForumApi;
    BBSPayManager *_payManager;

    BBSPrivateMessage *_privateMessage;
}

@end


@implementation BBSWritePMViewController

// 上一Cotroller传递过来的数据
- (void)transBundle:(TranslateData *)bundle {
    if ([bundle containsKey:@"isReply"]) {
        isReply = YES;
        _privateMessage = [bundle getObjectValue:@"toReplyMessage"];

        _toUser = [[UserCount alloc] init];
        _toUser.userName = _privateMessage.pmAuthor;
        _toUser.userID = _privateMessage.pmAuthorId;

    } else {
        _toUser = [bundle getObjectValue:@"PROFILE_NAME"];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];

//    if (@available(iOS 13.0, *)) {
//        self.toWho.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//        self.privateMessageTitle.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//    }

    _localForumApi = [[BBSLocalApi alloc] init];

    // payManager
    _payManager = [BBSPayManager shareInstance];

    if (isReply) {
        self.toWho.enabled = NO;
        self.toWho.text = _toUser.userName;
        self.privateMessageTitle.text = [NSString stringWithFormat:@"回复：%@", _privateMessage.pmTitle];
        [self.privateMessageContent becomeFirstResponder];
    } else {
        self.toWho.enabled = YES;
        if (_toUser != nil) {
            self.toWho.text = _toUser.userName;
            [self.privateMessageTitle becomeFirstResponder];
        } else {
            [self.toWho becomeFirstResponder];
        }
    }

    
}

- (void)viewDidAppear:(BOOL)animated {
    if (![_payManager hasPayed:[_localForumApi currentProductID]]) {
        [self showFailedMessage:@"私信需要解锁高级功能"];
    }
}

- (void)showFailedMessage:(id)message {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作受限" message:message preferredStyle:UIAlertControllerStyleAlert];


    UIAlertAction *showPayPage = [UIAlertAction actionWithTitle:@"解锁" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        UIViewController *controller = [[UIStoryboard mainStoryboard] finControllerById:@"ShowPayPage"];

        [self presentViewController:controller animated:YES completion:^{

        }];

    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        [self dismissViewControllerAnimated:YES completion:^{

        }];

    }];

    [alert addAction:cancel];

    [alert addAction:showPayPage];


    [self presentViewController:alert animated:YES completion:^{

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

- (IBAction)sendPrivateMessage:(id)sender {

    if ([self.toWho.text isEqualToString:@""]) {
        [ProgressDialog showError:@"无收件人"];
    } else if ([self.privateMessageTitle.text isEqualToString:@""]) {
        [ProgressDialog showError:@"无标题"];
    } else if ([self.privateMessageContent.text isEqualToString:@""]) {
        [ProgressDialog showError:@"无内容"];
    } else {

        [self.privateMessageContent resignFirstResponder];

        [ProgressDialog showStatus:@"正在发送"];

        if (isReply) {

            [self.forumApi replyPrivateMessage:_privateMessage andReplyContent:self.privateMessageContent.text handler:^(BOOL isSuccess, id message) {
                [ProgressDialog dismiss];

                if (isSuccess) {
                    [self dismissViewControllerAnimated:YES completion:^{

                    }];
                } else {
                    [ProgressDialog showError:message];
                }
            }];
        } else {
            [self.forumApi sendPrivateMessageTo:_toUser andTitle:self.privateMessageTitle.text andMessage:self.privateMessageContent.text handler:^(BOOL isSuccess, id message) {

                [ProgressDialog dismiss];

                if (isSuccess) {
                    [self dismissViewControllerAnimated:YES completion:^{

                    }];
                } else {
                    [ProgressDialog showError:message];
                }

            }];
        }

    }
}

@end
