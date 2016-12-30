//
//  TRComposePhotosView.h
//  露露微博
//
//  Created by lushuishasha on 15/9/23.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//   发微博图片的大小设置

#import <UIKit/UIKit.h>

@interface TRComposePhotosView : UIView
//跟- (NSArray *)photos一样的，只生成get方法
@property (nonatomic, strong, readonly) NSMutableArray *photos;
- (void)addPhoto:(UIImage *)photo;
@end
