//
//  TRAccount.h
//  露露微博
//
//  Created by lushuishasha on 15/8/14.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRAccount : NSObject<NSCoding>
/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSString *expries_in;
/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong)  NSDate *created_time;

@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
