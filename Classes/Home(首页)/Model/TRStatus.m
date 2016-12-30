//
//  TRStatus.m
//  露露微博
//
//  Created by lushuishasha on 15/8/15.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRStatus.h"
#import "MJExtension.h"
#import "TRPhoto.h"
#import "NSDate+Extension.h"
@implementation TRStatus
- (NSDictionary *)objectClassInArray {
    return @{@"pic_urls":[TRPhoto class]};
}


- (NSString *)created_at {
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    
    NSDate *createDtate = [fmt dateFromString:_created_at];
    NSDate *now = [NSDate date];

    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |
    NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
   //计算两个日期之间的差值
    NSDateComponents *cmps = [calender components:unit fromDate:createDtate toDate:now options:0];
    
    if ([createDtate isThisYear]) {//是今年
        if ([createDtate isYesterday]) {//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDtate];
        } else if([createDtate isToday]) {//今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前",(int)cmps.hour];
            }else if(cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前",(int)cmps.minute];
            }else {
                return @"刚刚";
            }
        }else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDtate];
        }
    }else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDtate];
    }
}




- (void)setSource:(NSString *)source {
   // _source = source;
    //NSRegularExpression 正则表达式
    //截串
    NSRange range ;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
}


@end
