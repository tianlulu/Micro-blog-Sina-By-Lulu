//
//  TRLoadMoreFooter.m
//  露露微博
//
//  Created by lushuishasha on 15/8/15.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRLoadMoreFooter.h"

@implementation TRLoadMoreFooter
+ (instancetype) footer {
    return [[[NSBundle mainBundle] loadNibNamed:@"TRLoadMoreFooter" owner:nil options:nil] lastObject];
}
@end
