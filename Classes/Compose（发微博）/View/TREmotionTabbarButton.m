//
//  TREmotionTabbarButton.m
//  露露微博
//
//  Created by lushuishasha on 15/9/24.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TREmotionTabbarButton.h"

@implementation TREmotionTabbarButton
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        
        //设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

//不存在高亮状态
- (void)setHighlighted:(BOOL)highlighted {
    //按钮高亮所在的一切操作都不在了
    
}
@end
