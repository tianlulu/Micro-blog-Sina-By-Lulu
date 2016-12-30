//
//  mainTabBarViewController.m
//  露露微博
//
//  Created by lushuishasha on 15/8/10.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "mainTabBarViewController.h"
#import "homeViewController.h"
#import "messageViewController.h"
#import "profileViewController.h"
#import "discoverViewController.h"
#import "mianVavigationController.h"
@interface mainTabBarViewController ()
//随机色
#define RandomColor2  [UIColor colorWithRed:arc4random_uniform(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:(256)/255.0 blue:(256)/255.0 alpha:1.0]
@end

@implementation mainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    homeViewController *homeVC = [[homeViewController alloc]init];
    [self addChildVc:homeVC title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    
    messageViewController *messageVC = [[messageViewController alloc]init];
    [self addChildVc:messageVC title:@"消息" image:@"tabbar_message_center" selectedImage: @"tabbar_message_center_selected"];
    
    
    discoverViewController *discoverVC = [[discoverViewController alloc]init];
    [self addChildVc:discoverVC title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    
    profileViewController *profileVC = [[profileViewController alloc]init];
    [self addChildVc:profileVC title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    
    //tabbarVC.viewControllers = @[vc1,vc2,vc3,vc4,vc5];
//    [tabbarVC addChildViewController:homeVC];
//    [tabbarVC addChildViewController:messageVC];
//    [tabbarVC addChildViewController:discoverVC];
//    [tabbarVC addChildViewController:profileVC];
}



- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title
image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
     //    childVc.tabBarItem.title = title;
    //    childVc.navigationItem.title = title;
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage =[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *textAttrs2 = [NSMutableDictionary dictionary];
    textAttrs2[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs2 forState:UIControlStateSelected];
    childVc.view.backgroundColor = RandomColor;
    mianVavigationController *nav = [[mianVavigationController alloc]initWithRootViewController:childVc];

    [self addChildViewController:nav];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
