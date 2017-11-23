//
//  GAMotionBlurFileterModel.m
//  Honey
//
//  Created by 李高锋 on 2017/9/28.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "GAMotionBlurFileterModel.h"

@implementation GAMotionBlurFileterModel

+ (NSString *)filterName {
    
    return @"动态模糊";
}

+ (UIImage *)defaultImageWithImage:(UIImage *)image {
    
    return [image motionBlurWithRadious:10 andAngle:M_PI_2];
}

+ (UIImage *)image:(UIImage *)image blurRadious:(CGFloat)radious blurParam:(id)param {
    return [image motionBlurWithRadious:radious andAngle:[param floatValue]];
}

@end
