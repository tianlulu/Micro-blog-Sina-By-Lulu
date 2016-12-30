//
//  TREmotionAttachment.h
//  露露微博
//
//  Created by lushuishasha on 15/10/12.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
// //自定义表情附件

#import <UIKit/UIKit.h>
@class TREmotion;
@interface TREmotionAttachment : NSTextAttachment
@property (nonatomic, strong) TREmotion *emotion;
@end
