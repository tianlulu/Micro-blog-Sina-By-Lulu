//
//  TRStatusToolBar.m
//  露露微博
//
//  Created by lushuishasha on 15/8/20.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRStatusToolBar.h"
#import "UIView+Extension.h"

@interface TRStatusToolBar()
/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;
@property (nonatomic, weak) UIButton *respostBtn;
@property (nonatomic, weak) UIButton *commnentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
@end

@implementation TRStatusToolBar
- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}


- (NSMutableArray *)dividers {
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}



+ (instancetype)toolbar {
    return [[self alloc]init];
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.respostBtn = [self setUpBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.commnentBtn =[self setUpBtn:@"评论" icon:@"timeline_icon_comment"];
         self.attitudeBtn =[self setUpBtn:@"赞" icon:@"timeline_icon_unlike"];
        
        //用于平铺,连一起图片
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}


- (void)setupDivider {
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
       for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btn.width;
        btn.height = btnH;
    }
    // 设置分割线的frame
    NSUInteger dividerCount = self.dividers.count;
    for (int i = 0 ;  i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) *btnW;
        divider.y = 0;
    }
}


//初始化一个按钮
- (UIButton *) setUpBtn:(NSString *)title icon:(NSString *)icon {
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}


- (void) setStatus:(TRStatus *)status {
    _status = status;
    [self setUpBtnCount:status.reposts_count btn:self.respostBtn title:@"转发"];
    [self setUpBtnCount:status.comments_count btn:self.commnentBtn title:@"评论"];
    [self setUpBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
}


- (void) setUpBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title {
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        }else {
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
