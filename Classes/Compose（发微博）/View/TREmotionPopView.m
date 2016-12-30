//
//  TREmotionPopView.m
//  露露微博
//
//  Created by lushuishasha on 15/9/28.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TREmotionPopView.h"
#import "TREmotion.h"
#import "TREmotionButton.h"
#import "UIView+Extension.h"

@interface TREmotionPopView()
@property (weak, nonatomic) IBOutlet TREmotionButton *emotionButton;

@end
@implementation TREmotionPopView

+  (instancetype)popView {
    return [[[NSBundle mainBundle] loadNibNamed:@"TREmotionPopView" owner:nil options:nil]lastObject];
}


//popView里面的表情按钮的显示
//- (void)setEmotion:(TREmotion *)emotion {
//    _emotion = emotion;
//    
//    self.emotionButton.emotion = emotion;
//}


- (void)showFrom : (TREmotionButton *)button {
    if (button == nil) return;
    
    //给popView传递数据
    self.emotionButton.emotion = button.emotion;
    //取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    
    //计算被点击的按钮在window的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height;
    self.centerX = CGRectGetMidX(btnFrame);
}


@end
