//
//  FirstScrollView.m
//  露露微博
//
//  Created by lushuishasha on 15/8/13.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "FirstScrollView.h"
#import "UIView+Extension.h"
#import "mainTabBarViewController.h"
@interface FirstScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong)NSArray *allImageNames;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation FirstScrollView
- (NSArray *)allImageNames {
    if (!_allImageNames) {
        _allImageNames = @[@"new_feature_1",@"new_feature_2",@"new_feature_3",@"new_feature_4"];
    }
    return _allImageNames;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    self.scrollView = scrollView;
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width *self.allImageNames.count, scrollView.frame.size.height);
    
    
    for (int i = 0; i < self.allImageNames.count; i++) {
        UIImage *image = [UIImage imageNamed:self.allImageNames[i]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        CGRect imageFrame = CGRectZero;
        imageFrame.size = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height);
        imageFrame.origin = CGPointMake(scrollView.bounds.size.width *i , 0);
        imageView.frame = imageFrame;
        [scrollView addSubview:imageView];
        
        if (i== self.allImageNames.count-1) {
            [self setUpLastImageView:imageView];
        }
    }
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
     [self.view addSubview:scrollView];
    
    
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
      self.pageControl = pageControl;
    
    pageControl.numberOfPages = self.allImageNames.count;
    
    pageControl.userInteractionEnabled = NO;
    
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.centerY = scrollView.frame.size.height - 50;
    pageControl.centerX = scrollView.frame.size.width * 0.5;
    //配置
    
    [self.view addSubview:pageControl];
   
}

- (void)setUpLastImageView:(UIImageView *)imageView {
    //分享给大家
    imageView.userInteractionEnabled = YES;
    
    UIButton *sharButton = [[UIButton alloc] init];
    [sharButton setImage:[UIImage imageNamed:@"new_feature_share_false" ] forState:UIControlStateNormal];
    [sharButton setImage:[UIImage imageNamed:@"new_feature_share_true" ] forState:UIControlStateSelected];
    [sharButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [sharButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sharButton.titleLabel.font = [UIFont systemFontOfSize:15];
    sharButton.size = CGSizeMake(200, 30);
    sharButton.centerX = imageView.width * 0.5;
    sharButton.centerY = imageView.height * 0.7;
    sharButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [sharButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:sharButton];
   
    //开始微博
    UIButton *startButton = [[UIButton alloc]init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateSelected];
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = sharButton.centerX;
    startButton.centerY = imageView.height *0.78;
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
}



- (void)shareClick:(UIButton *)shareButton {
    shareButton.selected = !shareButton.isSelected;
}

- (void)startClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[mainTabBarViewController alloc]init];
    
    // modal方式，不建议采取：新特性控制器不会销毁
    //    HWTabBarViewController *main = [[HWTabBarViewController alloc] init];
    //    [self presentViewController:main animated:YES completion:nil];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = (int)(page +0.5);
}

@end
