//
//  GABlurFileterModel.m
//  Honey
//
//  Created by 李高锋 on 2017/9/15.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "GAGuessBlurFileterModel.h"

@implementation GAGuessBlurFileterModel

+ (NSString *)filterName {
 
    return @"高斯模糊";
}

+ (UIImage *)defaultImageWithImage:(UIImage *)image {
    
    return [image gaussianBlurWithRadious:10];
}

+ (UIImage *)image:(UIImage *)image blurRadious:(CGFloat)radious blurParam:(id)param {
    return [image gaussianBlurWithRadious:radious];
}

@end
