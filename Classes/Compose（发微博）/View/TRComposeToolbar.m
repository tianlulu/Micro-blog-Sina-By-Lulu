//
//  TRComposeToolbar.m
//  露露微博
//
//  Created by lushuishasha on 15/9/23.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

//发微博时的工具条（表情，其实是4个button）

#import "TRComposeToolbar.h"
#import "UIView+Extension.h"
@interface TRComposeToolbar()
@property  (nonatomic ,strong) UIButton * emotionButton;
@end


@implementation TRComposeToolbar
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        //设置初始化按钮
        [self setUpButton:@"compose_camerabutton_background"  highlightedImage:@"compose_camerabutton_background_highlighted" type:TRComposeToolbarButtonTypeCamera];
         [self setUpButton:@"compose_toolbar_picture"  highlightedImage:@"compose_toolbar_picture_highlighted" type:TRComposeToolbarButtonTypePicture];
         [self setUpButton:@"compose_mentionbutton_background"  highlightedImage:@"compose_mentionbutton_background_highlighted" type:TRComposeToolbarButtonTypeMention];
         [self setUpButton:@"compose_trendbutton_background"  highlightedImage:@"compose_trendbutton_background_highlighted" type:TRComposeToolbarButtonTypeTrend];
        self.emotionButton =  [self setUpButton:@"compose_emoticonbutton_background"  highlightedImage:@"compose_emoticonbutton_background_highlighted" type:TRComposeToolbarButtonTypeEmotion];
        
    }
    return self;
}



- (void)setShowEmotionButton:(BOOL)showEmotionButton {
    _showEmotionButton = showEmotionButton;
    if (showEmotionButton) {
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
        
    }else {
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
        
    }
}



//创建一个按钮
- (UIButton *)setUpButton:(NSString *)image highlightedImage:(NSString *)highlightedImage type:(TRComposeToolbarButtonType)type{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //给每一个按钮绑定一个枚举值
    btn.tag = type;
    [self addSubview:btn];
    return btn;
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    //设置所有按钮的frame
    NSInteger count = self.subviews.count;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = self.width / count;
        btn.x = i * btn.width;
        btn.height = self.height;
    }
}


- (void)btnClick: (UIButton *)btn {
    //NSLog(@"btnClick-%.0f",btn.x / btn.width);
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
       // NSUInteger index = (NSUInteger)(btn.x / btn.width);
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
}
@end
