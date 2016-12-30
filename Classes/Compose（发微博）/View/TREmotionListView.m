//
//  TREmotionListView.m
//  露露微博
//
//  Created by lushuishasha on 15/9/24.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TREmotionListView.h"
#import "UIView+Extension.h"
#import "TREmotionView.h"

#define TREmotionPageSize 20
@interface TREmotionListView()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, weak) UIPageControl *pageControl;
@end


@implementation TREmotionListView
- (id)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //1.UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollview = scrollView;
        
        //2.pageContrl
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.userInteractionEnabled = NO;
        pageControl.hidesForSinglePage = YES;
        //pageControl.backgroundColor = [UIColor whiteColor];
        //kvo设置私有属性，直接改图片，不会造成平铺
       // pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_selected"]];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
         self.pageControl = pageControl;
    }
    return self;
}



//listView所有的表情表情个数
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    //每次点击最近的时候，删除之前的pageView重新算一次
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSLog(@"表情数量:%ld",emotions.count);
    
    //根据emotions，创建对应个数的表情页数
    NSInteger count = (emotions.count + TREmotionPageSize - 1) / TREmotionPageSize;
    
    //1.设置页数
    self.pageControl.numberOfPages = count;
    
    //2.创建用来显示每一页表情的控件
    for (int i = 0; i < count; i++) {
       TREmotionView *pageView = [[TREmotionView alloc]init];
        
    //计算这一页的表情范围
        NSRange range;
        range.location = i * TREmotionPageSize;
        
        //left剩余的表情个数
        NSUInteger left = emotions.count - range.location;;
        if (left >= TREmotionPageSize) {
            range.length = TREmotionPageSize;
        } else {
            range.length = left;
        }
        //设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollview addSubview:pageView];
        [self setNeedsLayout];
    }
}



- (void)layoutSubviews {
    [super layoutSubviews];
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollview.width = self.width;
    self.scrollview.height = self.pageControl.y;
    self.scrollview.x = self.scrollview.y = 0;
    
    //设置scrollvie内部每一页的尺寸
    NSInteger count = self.scrollview.subviews.count;
    for (int i  = 0; i < count;  i++) {
        TREmotionView *pageView = self.scrollview.subviews[i];
        pageView.width = self.scrollview.width;
        pageView.height = self.scrollview.height;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    //设置scrollview的contentSize
    self.scrollview.contentSize = CGSizeMake(count * self.scrollview.width, 0);
}


#pragma mark - scrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
    
}
@end
