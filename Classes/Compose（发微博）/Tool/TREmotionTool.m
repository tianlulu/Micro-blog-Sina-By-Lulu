//
//  TREmotionTool.m
//  露露微博
//
//  Created by lushuishasha on 15/10/12.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
// 最近的表情要从沙盒中取出

#define TREmotionsPath     [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]


#import "TREmotionTool.h"
#import "TREmotion.h"
@implementation TREmotionTool
static NSMutableArray *_recentEmotions;
//保证在内存中只有一份，不会反复的读取
+ (void)initialize {
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:TREmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

//类方法不能访问成员变量
+ (void)saveRecentEmotion: (TREmotion *)emotion{
//加载沙盒中的表情数据
//    NSMutableArray *emotions = (NSMutableArray *)[self takeRecentEmotions];
//    if (emotions == nil) {
//        emotions = [NSMutableArray array];
//    }
    
    
    //删除重复的表情
    [_recentEmotions removeObject:emotion];
//    for (TREmotion *e in emotions) {
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code] ) {
//            [emotions removeObject:e];
//            break;
//        }
//    }
    
   //将表情放到数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    //将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:TREmotionsPath];
}



//返回装着emotion模型的数组
+ (NSArray *)takeRecentEmotions{
    return _recentEmotions;
}
@end
