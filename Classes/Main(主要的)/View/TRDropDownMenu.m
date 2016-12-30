//
//  TRDropDownMenu.m
//  露露微博
//
//  Created by lushuishasha on 15/8/11.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRDropDownMenu.h"
#import "UIView+Extension.h"

@interface TRDropDownMenu()
// 添加一个灰色图片控件
@property (nonatomic, weak) UIImageView *containerView;
@end
@implementation TRDropDownMenu


- (UIImageView *)containerView {
    //弱指正不能用懒加载，除非先创建它
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
//        containerView.width = 217;
//        containerView.height = 217;
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
        }
    return self;
}


- (void)showFrom:(UIView *)from {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
       
    //只是有了cover的大小
    self.frame = window.bounds;
    
    //转换坐标系(从左边的坐标系转换到右边的坐标系)
    //CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.y = CGRectGetMaxY(newFrame);
    //from的中心点
    self.containerView.centerX = CGRectGetMidX(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenuShow:)]) {
        [self.delegate dropDownMenuShow:self];
    }
}



+ (instancetype)menu {
    return [[self alloc] init];
}


- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
}


- (void) dismiss {
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        [self.delegate dropDownMenuDidDismiss:self];
    }
}

- (void) setContent:(UIView *)content {
    _content = content;
    // 调整内容的位置
    content.x = 10;
    content.y = 15;
    
    // 设置灰色的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    [self.containerView addSubview:content];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
