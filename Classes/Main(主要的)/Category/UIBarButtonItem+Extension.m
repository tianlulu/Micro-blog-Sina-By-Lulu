//
//  UIBarButtonItem+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *  
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [itemButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [itemButton setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    itemButton.size = itemButton.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:itemButton];
}
@end
