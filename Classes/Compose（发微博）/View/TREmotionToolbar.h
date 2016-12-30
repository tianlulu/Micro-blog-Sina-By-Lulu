//
//  TREmotionToolbar.h
//  露露微博
//
//  Created by lushuishasha on 15/9/24.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    TREmotionToolbarButtonTypeRecent,   //最近
    TREmotionToolbarButtonTypeDefault, //moren
    TREmotionToolbarButtonTypeEmoji,  //emoji
    TREmotionToolbarButtonTypeLxh,    //浪小花
}TREmotionToolbarButtonType;


@class TREmotionToolbar;
@protocol TREmotionToolbarDelegate<NSObject>
@optional
- (void)emotionToolbar:(TREmotionToolbar *)toolBar didSelectedButton:(TREmotionToolbarButtonType)buttonType;
@end

@interface TREmotionToolbar : UIView
@property (nonatomic , weak) id<TREmotionToolbarDelegate>delegate;
@end
