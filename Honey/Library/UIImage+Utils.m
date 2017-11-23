//
//  UIImage+Utils.m
//  Honey
//
//  Created by 李高锋 on 2017/9/16.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage *)timeImage {
    
    NSDate * currentDate = [NSDate date];
    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
    NSDate * newDate = [currentDate dateByAddingTimeInterval:timeZoneOffset];
    NSCalendar * cal= [NSCalendar currentCalendar];
    NSDateComponents * compon = [cal components:NSCalendarUnitYear | kCFCalendarUnitWeek | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:newDate];
    
    switch ([compon month]) {
        case 2:
        case 3:
        case 4:
        {
            //spring
            return [UIImage imageNamed:@"spring.jpg"];
        }
            break;
        case 5:
        case 6:
        case 7:
        {
            //summer
            return [UIImage imageNamed:@"summer.jpg"];
        }
            break;
        case 8:
        case 9:
        case 10:
        {
            //autum
            return [UIImage imageNamed:@"autumn.jpg"];
        }
            break;
        case 11:
        case 12:
        case 1:
        {
            //snow
            return [UIImage imageNamed:@"snowbg.jpg"];
            
        }
            break;
            
        default:
            return [UIImage imageNamed:@"snowbg.jpg"];
            break;
    }
}

@end
