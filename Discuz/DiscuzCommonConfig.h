//
// Created by 迪远 王 on 2018/6/2.
// Copyright (c) 2018 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForumBaseConfigDelegate.h"
#import "DiscuzConfigDelegate.h"


@interface DiscuzCommonConfig : NSObject<ForumBaseConfigDelegate, DiscuzConfigDelegate>

@property NSURL *forumURL;

@end