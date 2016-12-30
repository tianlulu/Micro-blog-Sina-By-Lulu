//
//  TRDropDownMenu.h
//  露露微博
//
//  Created by lushuishasha on 15/8/11.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <UIKit/UIKit.h>
//设置首页弹出的黑色框框
@class TRDropDownMenu;

@protocol  TRDropDownMenuDelagate<NSObject>
- (void)dropDownMenuDidDismiss:(TRDropDownMenu *)menu;
- (void)dropDownMenuShow:(TRDropDownMenu *)menu;
@end


@interface TRDropDownMenu : UIView
@property (nonatomic, weak) id<TRDropDownMenuDelagate>delegate;

@property (nonatomic, strong) UIView *content;
@property (nonatomic,strong) UIViewController *contentController;
+ (instancetype)menu;
- (void)showFrom:(UIView *)from;
- (void)dismiss;
@end
