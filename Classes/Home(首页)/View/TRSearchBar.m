//
//  TRSearchBar.m
//  露露微博
//
//  Created by lushuishasha on 15/8/11.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRSearchBar.h"
#import "UIView+Extension.h"

@implementation TRSearchBar
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
       
        UIImageView *searchIcon = [[UIImageView alloc]init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView =  searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}


+ (instancetype)searchBar {
    return [[self alloc]init];
}
@end
