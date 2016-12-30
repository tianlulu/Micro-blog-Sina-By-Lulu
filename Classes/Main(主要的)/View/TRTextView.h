//
//  TRTextView.h
//  露露微博
//
//  Created by lushuishasha on 15/9/23.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRTextView : UITextView
//占位文字
@property (nonatomic, copy) NSString *placeholder;
//占位文字的颜色
@property (nonatomic, strong) UIColor *placeholderColor;
@end
