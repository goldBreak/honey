//
//  GABoxBlurFilterModel.m
//  Honey
//
//  Created by 李高锋 on 2017/9/28.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "GABoxBlurFilterModel.h"

@implementation GABoxBlurFilterModel

+ (NSString *)filterName {
    
    return @"盒子模糊";
}

+ (UIImage *)defaultImageWithImage:(UIImage *)image {
    
    return [image boxBlurWithRadious:10];
}

+ (UIImage *)image:(UIImage *)image blurRadious:(CGFloat)radious blurParam:(id)param {
    return [image boxBlurWithRadious:radious];
}
@end
