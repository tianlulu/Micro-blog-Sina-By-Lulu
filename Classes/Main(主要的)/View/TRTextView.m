//
//  TRTextView.m
//  露露微博
//
//  Created by lushuishasha on 15/9/23.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//占位文字功能

#import "TRTextView.h"

@implementation TRTextView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //通知 当文字改变时，自己发出通知，也是自己监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



//监听文字的改变
- (void)textDidChange {

     //重绘，在需要的时候调用drawRect方法
    [self setNeedsDisplay];
}


//如果用代码可以立马显示新的信息
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}


- (void)setFont:(UIFont *)font {
    [super setFont:font];
     
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}


- (void) drawRect:(CGRect)rect {
    //画出来的东西不会随着光标移动
    
    //如果有输入文字，直接返回，不画占位文字
    if (self.hasText) return;
    
    //文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    
    CGRect placeholderRect = CGRectMake(5, 8, rect.size.width - 2 * 5, rect.size.height - 2 * 8);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}
@end
