//
//  NSDate+Extension.m
//  露露微博
//
//  Created by lushuishasha on 15/8/22.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断某个时间是否为今年
 */
- (BOOL) isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
    
}


/**
 *  判断某个时间是否为昨天
 */
- (BOOL) isYesterday {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dataStr = [fmt stringFromDate:self];
    NSString *nowStr =  [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dataStr];
    now =[fmt dateFromString:nowStr];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calender components:unit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month ==0 && cmps.day == 1;
}



/**
 *  判断某个时间是否为今天
 */
- (BOOL) isToday {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr =[fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    return [dateStr isEqualToString:nowStr];
}
@end
