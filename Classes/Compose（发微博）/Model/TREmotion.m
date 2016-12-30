//
//  TREmotion.m
//  露露微博
//
//  Created by lushuishasha on 15/9/25.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TREmotion.h"
@interface TREmotion ()<NSCoding>
@end
@implementation TREmotion
/**
*  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
*  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
*/
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}


/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
}


//常用来比较两个对象是否一样
- (BOOL)isEqual:(TREmotion *)other {
   // return self == other;
    return [self.chs isEqual:other.chs] || [self.code isEqual:other.code];
}
@end
