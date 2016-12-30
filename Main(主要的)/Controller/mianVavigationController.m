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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
