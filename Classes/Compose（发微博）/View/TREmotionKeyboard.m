//
//  TREmotionKeyboard.m
//  露露微博
//
//  Created by lushuishasha on 15/9/24.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TREmotionKeyboard.h"
#import "TREmotionToolbar.h"
#import "TREmotionListView.h"
#import "UIView+Extension.h"
#import "TREmotionTabbarButton.h"
#import "TREmotion.h"
#import "MJExtension.h"
#import "TREmotionTool.h"
@interface TREmotionKeyboard()<TREmotionToolbarDelegate>
@property (nonatomic, strong) TREmotionListView *recentListView;
@property (nonatomic, strong) TREmotionListView *defaultListView;
@property (nonatomic, strong) TREmotionListView *emojiListView;
@property (nonatomic, strong) TREmotionListView *lxhListView;
@property (nonatomic, weak) TREmotionToolbar *toolBar;

//保存正在显示的listView
@property (nonatomic, strong) TREmotionListView *showingListView;
//容纳表情内容的控件
//@property (nonatomic, weak) UIView *contentView;
@end


@implementation TREmotionKeyboard
#pragma mark --懒加载
-(TREmotionListView *)recentListView {
    if (!_recentListView) {
        _recentListView = [[TREmotionListView alloc]init];
        NSLog(@"%@",self.recentListView.emotions);
    }
    return _recentListView;
}

-(TREmotionListView *)defaultListView {
    if (!_defaultListView) {
        _defaultListView = [[TREmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [TREmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}



-(TREmotionListView *)emojiListView {
    if (!_emojiListView) {
        _emojiListView = [[TREmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [TREmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}



-(TREmotionListView *)lxhListView {
    if (!_lxhListView) {
        _lxhListView = [[TREmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [TREmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}



#pragma mark---初始化方法
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        UIView *contentView = [[UIView alloc]init];
//        [self addSubview:contentView];
//        self.contentView = contentView;
        
        
        TREmotionToolbar *toolBar = [[TREmotionToolbar alloc]init];
        toolBar.delegate = self;
        [self addSubview:toolBar];
        self.toolBar = toolBar;
        
        
        //监听表情选中的通知,一旦选中表情，就可以拿到操作self.recentListView.emotions = [TREmotionTool takeRecentEmotions];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDidSelect) name:@"TREmotionDidSelectedNotification" object:nil];
        
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)emotionDidSelect {
    //只要监听到表情被插入到数组的最前面的通知，就会自动调用这个方法从沙盒在取出最近的表情数据，不用切换到最近就调用这个方法
    self.recentListView.emotions = [TREmotionTool takeRecentEmotions];
}



//只有第一次使用或者是重新计算子控件的时候调用
- (void) layoutSubviews {
    [super layoutSubviews];
    
    //设置TREmotionKeyboard里面子控件的frame
    self.toolBar.width = self.width;
    self.toolBar.height = 37;
    self.toolBar.x = 0;
    self.toolBar.y = self.height - self.toolBar.height;
    
    
    self.showingListView.x  = self.showingListView.y = 0;
    self.showingListView.height = self.toolBar.y;
    self.showingListView.width  = self.width;
//
//    UIView *child = [self.contentView.subviews lastObject];
//    child.frame = self.contentView.bounds;
    
}


- (void)emotionToolbar:(TREmotionToolbar *)toolBar didSelectedButton:(TREmotionToolbarButtonType)buttonType {
    //移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    
    switch (buttonType) {
            
        //[self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        case TREmotionToolbarButtonTypeRecent: {
            //[self.contentView addSubview:self.recentListView];
           // self.showingListView = self.recentListView;
            //当切换到最近的时候，就从沙盒里重新加载数据
            [self addSubview:self.recentListView];
            break;
        }
            
        case TREmotionToolbarButtonTypeDefault:{
            //[self.contentView addSubview:self.defaultListView];
            //self.showingListView = self.defaultListView;
            [self addSubview:self.defaultListView];
            break;
        }
            

        case TREmotionToolbarButtonTypeEmoji:{
            //[self.contentView addSubview:self.emojiListView];
            //self.showingListView = self.emojiListView;
            [self addSubview:self.emojiListView];
            break;
        }

           
        case TREmotionToolbarButtonTypeLxh:{
           // [self.contentView addSubview:self.lxhListView];
            //self.showingListView = self.lxhListView;
            [self addSubview:self.lxhListView];
            break;
        }
    }
    //设置最新的正在显示listView
    self.showingListView = [self.subviews lastObject];
    //重新计算子控件的frame(内部会在恰当的时刻重新重新布局子空间)
    [self setNeedsLayout];
}

@end
