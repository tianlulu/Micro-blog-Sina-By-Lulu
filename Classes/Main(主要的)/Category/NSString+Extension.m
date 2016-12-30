//
//  NSString+Extension.m
//  露露微博
//
//  Created by lushuishasha on 15/8/21.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGSize)sizeWithfont:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    NSString *version = [UIDevice currentDevice].systemVersion;
    
   if ( [version doubleValue] >= 7.0)
    {
        NSLog(@"up-%@",version);
        //算文字尺寸 iOS 7.0才有的
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        
    }else {
         NSLog(@"down-%@",version);
        //ios 6.0
       return  [self sizeWithFont:font constrainedToSize:maxSize];
    }
    
}

- (CGSize)sizeWithFont:(UIFont *)font{
    return [self sizeWithfont:font maxW:MAXFLOAT];
}
@end
