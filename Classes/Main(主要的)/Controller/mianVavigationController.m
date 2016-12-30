//
//  mianVavigationController.m
//  露露微博
//
//  Created by lushuishasha on 15/8/10.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "mianVavigationController.h"
#import "UIView+Extension.h"
@interface mianVavigationController ()
@end

@implementation mianVavigationController

//系统提供的初始化方法，设置所有item的字体，颜色还有普通状态和disable的状态
+ (void) initialize {
    //设置普通的状态
    //设置整个项目所有的item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
    
    //设置文字的颜色
    textDic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textDic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textDic forState:UIControlStateNormal];
    
    //设置不可用的状态
    NSMutableDictionary *disableDic = [NSMutableDictionary dictionary];
    disableDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.7 alpha:0.7];
    disableDic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:disableDic forState:UIControlStateDisabled];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

//每次push一个控制器就会被拦截下来设置backButton，moreButton
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
      [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //设置图片
        [backButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_selected"] forState:UIControlStateHighlighted];
        
        backButton.size = backButton.currentBackgroundImage.size;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        //设置图片
        [moreButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_selected"] forState:UIControlStateHighlighted];
        
        moreButton.size = moreButton.currentBackgroundImage.size;
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
    }
    
}

- (void) back {
    [self popViewControllerAnimated:YES];
}


- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}



@end
