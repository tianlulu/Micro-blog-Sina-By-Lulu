//
//  TREmotionPopView.h
//  露露微博
//
//  Created by lushuishasha on 15/9/28.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

//popView里面有文字和图片
#import <UIKit/UIKit.h>
@class  TREmotion,TREmotionButton;
@interface TREmotionPopView : UIView

//把xib整体创建出来
+  (instancetype)popView;
//@property (nonatomic, strong) TREmotion *emotion;

//popView从这个按钮上弹出来
- (void) showFrom : (TREmotionButton *)button;
@end
