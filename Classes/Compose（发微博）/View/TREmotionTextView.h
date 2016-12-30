//
//  TREmotionTextView.h
//  露露微博
//
//  Created by lushuishasha on 15/10/9.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//  既有占位功能，又有表情显示功能

#import "TRTextView.h"

@class TREmotion;
@interface TREmotionTextView : TRTextView
- (void)insertEmotion:(TREmotion *)emotion;

//将所有的发微博的内容（图片png）拼接成字符串
- (NSString *)fullString;

@end
