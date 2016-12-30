//
//  TRStatusPhotosView.h
//  露露微博
//
//  Created by lushuishasha on 15/9/21.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
// cell上面的配图相册

#import <UIKit/UIKit.h>

@interface TRStatusPhotosView : UIView
@property (nonatomic, strong) NSArray *photos;

+ (CGSize)sizeWithCount: (int)count;
@end
