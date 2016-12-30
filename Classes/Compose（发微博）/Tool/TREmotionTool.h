//
//  TREmotionTool.h
//  露露微博
//
//  Created by lushuishasha on 15/10/12.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TREmotion;
@interface TREmotionTool : NSObject

//存到沙盒
+ (void)saveRecentEmotion: (TREmotion *)emotion;


//从沙盒中取出
+ (NSArray *)takeRecentEmotions;
@end
