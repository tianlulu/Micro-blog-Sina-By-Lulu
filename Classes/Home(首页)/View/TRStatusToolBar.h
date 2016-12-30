//
//  TRStatusToolBar.h
//  露露微博
//
//  Created by lushuishasha on 15/8/20.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRStatus.h"
@class TRStatus;
@interface TRStatusToolBar : UIView
@property (nonatomic, strong) TRStatus *status;
+ (instancetype)toolbar;
@end
