//
//  TRComposeToolbar.h
//  露露微博
//
//  Created by lushuishasha on 15/9/23.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    TRComposeToolbarButtonTypeCamera,
    TRComposeToolbarButtonTypePicture,
    TRComposeToolbarButtonTypeMention,
    TRComposeToolbarButtonTypeTrend,
    TRComposeToolbarButtonTypeEmotion
}TRComposeToolbarButtonType;

//点击toolBar的按钮，能够弹出其他控制器的代理
@class TRComposeToolbar;
@protocol TRComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(TRComposeToolbar *)toolbar didClickButton:(TRComposeToolbarButtonType)buttonType;
@end


@interface TRComposeToolbar : UIView
@property (nonatomic, weak) id<TRComposeToolbarDelegate>delegate;
@property (nonatomic, assign) BOOL showEmotionButton;
@end
