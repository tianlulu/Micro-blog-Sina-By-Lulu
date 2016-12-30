//
//  TRStatusFrame.h
//  露露微博
//
//  Created by lushuishasha on 15/8/18.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 昵称字体
#define TRStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define TRStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define TRStatusCellSourceFont TRStatusCellTimeFont
// 正文字体
#define TRStatusCellContentFont [UIFont systemFontOfSize:14]
// 被转发微博的正文字体
#define TRStatusCellRetweetContentFont [UIFont systemFontOfSize:13]
#define TRStarusCellBorderw 10
#define TRStatusCellMargin 15


#define TRColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@class TRStatus;
@interface TRStatusFrame : NSObject
@property (nonatomic,strong) TRStatus *status;
@property (nonatomic, assign) CGRect originalViewF;
@property (nonatomic, assign) CGRect iconViewF;
@property (nonatomic, assign) CGRect vipViewF;
@property (nonatomic, assign) CGRect photosViewfF;
@property (nonatomic, assign) CGRect nameLabelF;
@property (nonatomic, assign) CGRect timeLabelF;
@property (nonatomic, assign) CGRect sourceLabelF;
@property (nonatomic, assign) CGRect contentLabelF;
@property (nonatomic, assign) CGFloat cellHeight;


/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;

/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;

/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;

@property (nonatomic, assign) CGRect toolBarF;









@end
