//
//  TRTabbar.h
//  露露微博
//
//  Created by lushuishasha on 15/8/12.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <UIKit/UIKit.h>
//因为系统的tabbar排版无法实现，自定义tabbar，实现layoutSubviews方法，tabbar才能正确排布,所以床架这个类
@class TRTabbar;
@protocol  TRTabbarDelegate<UITabBarDelegate>
- (void)tabBarDidClickPlusButton:(TRTabbar *)tabBar;
@end


@interface TRTabbar : UITabBar

@property (nonatomic, weak) id<TRTabbarDelegate> delegate;
@end
