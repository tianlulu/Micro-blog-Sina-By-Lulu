//
//  TRStatus.h
//  露露微博
//
//  Created by lushuishasha on 15/8/15.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  TRUser;
@interface TRStatus : NSObject
@property (nonatomic, copy) NSString * idstr;
@property (nonatomic ,copy) NSString *text;
@property (nonatomic, strong) TRUser *user;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic,copy) NSString *source;

/** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
@property (nonatomic, strong) NSArray *pic_urls;

/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic, strong) TRStatus *retweeted_status;

@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;
@end
