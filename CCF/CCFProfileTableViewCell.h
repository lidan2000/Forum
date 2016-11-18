//
//  CCFProfileTableViewCell.h
//  CCF
//
//  Created by 迪远 王 on 16/3/20.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "BaseFourmTableViewCell.h"

@interface CCFProfileTableViewCell : BaseFourmTableViewCell
@property(weak, nonatomic) IBOutlet UIImageView *profileAvatar;
@property(weak, nonatomic) IBOutlet UILabel *profileUserName;
@property(weak, nonatomic) IBOutlet UILabel *profileRank;

@end
