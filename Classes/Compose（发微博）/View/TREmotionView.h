//
//  TREmotionView.h
//  露露微博
//
//  Created by lushuishasha on 15/9/28.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
// 用来表示一页的表情

#import <UIKit/UIKit.h>
//一页中最多3行
#define TREmotionMaxRows 3

//一行中最多7列
#define TREmotionMaxCols 7

//每一页的表情个数
#define TREmotionPageSize ((TREmotionMaxRows+ TREmotionMaxCols) -1)

@interface TREmotionView : UIView
//这一页显示的表情（里面全是TREmotion模型）
@property (nonatomic, strong) NSArray *emotions;
@end

