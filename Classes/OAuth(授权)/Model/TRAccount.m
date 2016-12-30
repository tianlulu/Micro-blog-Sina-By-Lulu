//
//  TRAccount.m
//  露露微博
//
//  Created by lushuishasha on 15/8/14.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRAccount.h"

@implementation TRAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict {
    TRAccount *account = [[TRAccount alloc]init];
    account.access_token = dict[@"access_token"];
    account.expries_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    //获得账号的存储时间
    account.created_time = [NSDate date];
    return account;
        
}


/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */

- (void) encodeWithCoder:(NSCoder *)enCoder {
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.expries_in forKey:@"expires_in"];
    [enCoder encodeObject:self.uid forKey:@"uid"];
    [enCoder encodeObject:self.created_time forKey:@"created_time"];
    [enCoder encodeObject:self.name forKey:@"name"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expries_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
    
}

@end
