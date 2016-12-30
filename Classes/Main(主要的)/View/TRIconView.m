//
//  TRIconView.m
//  露露微博
//
//  Created by lushuishasha on 15/9/22.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRIconView.h"
#import "TRUser.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface TRIconView()
@property (nonatomic, strong) UIImageView *verifiedView;
@end
@implementation TRIconView
- (UIImageView *)verifiedView {
    if (!_verifiedView) {
        UIImageView *vertifiedView = [[UIImageView alloc]init];
        [self addSubview:vertifiedView];
        self.verifiedView = vertifiedView;
    }
    return _verifiedView;
}

- (void)setUser:(TRUser *)user {
    _user = user;
    //下载头像图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //设置加v图片
    switch (user.verified_type) {
        case TRUserVerifiedPersonal:           //个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case TRUserVerifiedOrgEnterprice:     //官方认证
        case TRUserVerifiedTypeNoneOrgMedia:
        case TRUserVerifiedTypeNoneWebsite:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
            
        case TRUserVerifiedDaren:         //微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES;
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width *0.6;
    self.verifiedView.y = self.height - self.verifiedView.height *0.6;
}

@end
