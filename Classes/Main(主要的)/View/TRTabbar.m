//
//  TRTabbar.m
//  露露微博
//
//  Created by lushuishasha on 15/8/12.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRTabbar.h"
#import "UIView+Extension.h"
@interface TRTabbar()
@property (nonatomic, weak) UIButton *plusButton;
@end
@implementation TRTabbar

- (id)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        //添加一个按钮到tabbar
        UIButton *plusButton =[[UIButton alloc]init];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.size = plusButton.currentBackgroundImage.size;
        [self addSubview:plusButton];
        [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        self.plusButton = plusButton;
    }
    return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    //设置加号按钮的位置
    self.plusButton.centerX = self.width * 0.5;
    self.plusButton.centerY = self.height * 0.5;
    
    //设置其他tabbar的位置和尺寸
    CGFloat tabbarWidth = self.width / 5;
    CGFloat tabbarIndx = 0;
    for (UIView *childTabbar in self.subviews) {
     Class class = NSClassFromString(@"UITabBarButton");
        if ([childTabbar isKindOfClass:class]) {
            //设置宽度
            childTabbar.width = tabbarWidth;
            //设置x
           childTabbar.x = tabbarIndx *tabbarWidth;
            //增加索引
            tabbarIndx ++;
            if (tabbarIndx ==2) {
                tabbarIndx++;
            }
        }
    }
}


- (void) plusClick {
     // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}
@end
