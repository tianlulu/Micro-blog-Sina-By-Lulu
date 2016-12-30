//
//  TRStatusCell.h
//  露露微博
//
//  Created by lushuishasha on 15/8/18.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRStatusFrame;

@interface TRStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) TRStatusFrame *statusFrame;
@end
