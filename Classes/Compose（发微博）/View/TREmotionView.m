//
//  TREmotionView.m
//  露露微博
//
//  Created by lushuishasha on 15/9/28.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TREmotionView.h"
#import "TREmotion.h"
#import "UIView+Extension.h"
#import "NSString+Emoji.h"
#import "TREmotionPopView.h"
#import "TREmotionButton.h"
#import "TREmotionTool.h"
@interface TREmotionView()

//点击表情后弹出放大镜
@property (nonatomic, strong) TREmotionPopView *popView;
//删除按钮
@property (nonatomic, strong) UIButton *deleteButton;
@end
@implementation TREmotionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //删除按钮
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_lighlighted"] forState:UIControlStateHighlighted];
        
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        
        [self addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton = deleteButton;
        
        //给pageView添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    
    return self;
}


- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer {
    //获得手指在pageview所在的位置
    CGPoint location = [recognizer locationInView:recognizer.view];
    
    //已经找到了手指所在的表情按钮
    TREmotionButton *btn = [self emotionButtonWithLocation:location];
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan://手指开始（刚检测到长按）
        case UIGestureRecognizerStateChanged://手势改变 （手势的位置改变）
            //发出通知
            [self.popView showFrom:btn];
            break;
         
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled://手指已经不再触摸pageView
            [self.popView removeFromSuperview];
            //如果手指还在表情按钮上
            if (btn) {
                //发出通知
                [self selectEmotion:btn.emotion];
            }
              break;
            
        default:
            break;
    }
}




//根据手指的位置找到对应的表情按钮
- (TREmotionButton *)emotionButtonWithLocation: (CGPoint)location {
    NSUInteger count  = self.emotions.count;
    for (int i = 0; i < count; i++) {
        TREmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
           //如果位置在这个按钮上
            return btn;
        }
    }
    return nil;
}


//点击删除按删除图片或者文字
- (void)deleteClick {

    //只有控制器能够控制textView里面的文字，所以点击删除按钮的时候发送通知给控制器
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TREmotionDidDeleteNotification" object:nil];
}



- (TREmotionPopView *)popView {
    if (!_popView) {
        self.popView = [TREmotionPopView popView];
    }
    return _popView;
}


//pageView上面所有的button的显示
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
   // NSLog(@"--%d", emotions.count);
    NSInteger count = emotions.count;
    //设置表情数据
    for (int i = 0; i < count;  i++) {
        TREmotionButton *btn = [[TREmotionButton alloc]init];
        //btn.tag = i;
        [self addSubview:btn];
       
        //有图片
//        TREmotion *emotion = emotions[i];
//        if (emotion.png) {
//            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
//        }else if (emotion.code) {
//            //是emoji表情
//            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:32];
//            
//        }
        
        //设置表情数据
        btn.emotion = emotions[i];
        
        //监听表情按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //内边距（四周）
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / TREmotionMaxCols;
    CGFloat btnH = (self.height - inset) / TREmotionMaxRows;
    for (int i =  0; i < count; i ++) {
        UIButton * btn = self.subviews[i+1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % TREmotionMaxCols) * btnW;
        btn.y = inset + (i / TREmotionMaxCols) * btnH;
    }
    
    
    //删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.x = self.width - inset - btnW;
    self.deleteButton.y = self.height - btnH;
    
}

//被点击的表情按钮
- (void)btnClick:(TREmotionButton *)btn {
    TREmotion *emotion = btn.emotion;
    NSLog(@"emotion:%@,%@",emotion.png,emotion.chs);

////    //给popView传数据
//    self.popView.emotion = btn.emotion;
//
//    
////   //取得上面的window
//     UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//     [window addSubview:self.popView];
//
////    //计算被点击的按钮在window的frame
//    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
//    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
//    self.popView.centerX = CGRectGetMidX(btnFrame);
    
    //显示popView
    [self.popView showFrom:btn];
    
    //等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    [self selectEmotion:btn.emotion];
    
    }


- (void) selectEmotion: (TREmotion *)emotion {
    //将这个表情存进沙盒
    [TREmotionTool saveRecentEmotion:emotion];
    NSLog(@"%@已经存储",emotion.chs);
    //如果是跨了很多层的，不用代理用通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"selectedEmotion"] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TREmotionDidSelectedNotification"object:nil userInfo:userInfo];

    
}
@end
