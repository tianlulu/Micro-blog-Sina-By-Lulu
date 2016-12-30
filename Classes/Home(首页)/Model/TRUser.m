//
//  TRUser.m
//  露露微博
//
//  Created by lushuishasha on 15/8/15.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRUser.h"

@implementation TRUser
- (void) setMbtype:(int)mbtype {
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}
@end
