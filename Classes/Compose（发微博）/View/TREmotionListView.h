//
//  TREmotionListView.h
//  露露微博
//
//  Created by lushuishasha on 15/9/24.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TREmotionListView : UIView
//表情数组，是有顺序的,不管什么表情都可以传给listView（里面存放的是emotion模型）
@property (nonatomic, strong) NSArray *emotions;
@end
