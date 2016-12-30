//
//  TRUser.h
//  露露微博
//
//  Created by lushuishasha on 15/8/15.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    TRUserVerifiedTypeNone = -1,       //没有任何认证
    TRUserVerifiedPersonal = 0,        //个人认证
    TRUserVerifiedOrgEnterprice = 2,   //企业官方认证
    TRUserVerifiedTypeNoneOrgMedia = 3,
    TRUserVerifiedTypeNoneWebsite = 5,
    TRUserVerifiedDaren = 220          //微博达人
    
}TRUserVerifiedType;


@interface TRUser : NSObject
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *profile_image_url;
//会员类型 2代表会员
@property (nonatomic, assign) int mbtype;
//会员等级
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter=isVip) BOOL vip;

//认证类型
@property (nonatomic, assign) TRUserVerifiedType verified_type;
@end
