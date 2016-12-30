//
//  TREmotionToolbar.m
//  露露微博
//
//  Created by lushuishasha on 15/9/24.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TREmotionToolbar.h"
#import "UIView+Extension.h"
#import "TREmotionTabbarButton.h"

@interface TREmotionToolbar()
//选中按钮
@property (nonatomic, weak) TREmotionTabbarButton *selectedBtn;
@end


@implementation TREmotionToolbar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:TREmotionToolbarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:TREmotionToolbarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:TREmotionToolbarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:TREmotionToolbarButtonTypeLxh];
    }
    return self;
}



- (TREmotionTabbarButton *)setupBtn:(NSString *)title buttonType:(TREmotionToolbarButtonType)buttonType {
    TREmotionTabbarButton *button = [[TREmotionTabbarButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
   
    [self addSubview:button];
    button.tag = buttonType;
    if (buttonType == TREmotionToolbarButtonTypeDefault) {
        [self btnClick:button];
    }
    
    //点击按钮
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    //设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectedImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectedImage = @"compose_emotion_table_left_selected";
    } else if(self.subviews.count == 3) {
        image = @"compose_emotion_table_right_normal";
        selectedImage = @"compose_emotion_table_right_selected";
    }
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateDisabled];
    return button;
}



- (void) layoutSubviews {
    [super layoutSubviews];
    
    //设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i < btnCount; i++) {
        TREmotionTabbarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
    }
}

//默认为选中按钮
- (void)setDelegate:(id<TREmotionToolbarDelegate>)delegate {
    _delegate = delegate;
    //选中默认按钮
    [self btnClick:(TREmotionTabbarButton *)[self viewWithTag:TREmotionToolbarButtonTypeDefault]];
}



//按钮点击
- (void)btnClick:(TREmotionTabbarButton *)btn {
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:btn.tag];
    }
}
@end
