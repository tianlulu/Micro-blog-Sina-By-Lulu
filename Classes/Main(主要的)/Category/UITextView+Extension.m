//
//  UITextView+Extension.m
//  露露微博
//
//  Created by lushuishasha on 15/10/9.
//  Copyright © 2015年 Pass_Value. All rights reserved.
//

#import "UITextView+Extension.h"


@implementation UITextView (Extension)
- (void) insertAttributeText : (NSAttributedString *)text{
    
    // 拼接之前的文字（图片和普通文字）
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
    [attributedText appendAttributedString:self.attributedText];
    
    
    //拼接图片（降属性文字插入到光标位置）
    NSUInteger loc = self.selectedRange.location;
    //[attributedText insertAttributedString:text atIndex:loc];
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
    self.attributedText = attributedText;
    
    
    //移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}
@end
