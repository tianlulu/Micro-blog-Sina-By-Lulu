//
//  TRAccountTool.m
//  露露微博
//
//  Created by lushuishasha on 15/8/14.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//


#define TRAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"accoount.crchive"]

#import "TRAccountTool.h"
@implementation TRAccountTool
//存储账号到沙盒
+(void) saveAccount:(TRAccount *)account {
   
    [NSKeyedArchiver archiveRootObject:account toFile:TRAccountPath];
}


//从沙河中取出账号
+ (TRAccount *)returnAccount {
    TRAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:TRAccountPath];
    //验证账号是否过期
    //过期的秒数
    long long expires_in =[account.expries_in longLongValue];
    
    //存储时的时间 + 过期的秒数
   NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    NSDate *now = [NSDate date];
    //只有降序才不过期
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return  nil;
    }
    return account;
}

@end
