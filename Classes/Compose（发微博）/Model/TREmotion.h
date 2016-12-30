//
//  TREmotion.h
//  露露微博
//
//  Created by lushuishasha on 15/9/25.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//  plist文件里的字典数组要转换成模型数组字典转模型

#import <UIKit/UIKit.h>

@interface TREmotion : NSObject
//表情的文字描述
@property (nonatomic, copy) NSString *chs;

//表情png的图片名
@property (nonatomic, copy) NSString *png;

//emoji表情的16进制编码
@property (nonatomic, copy) NSString *code;

@end
