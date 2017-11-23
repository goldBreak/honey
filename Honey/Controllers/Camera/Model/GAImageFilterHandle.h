//
//  GAImageFilterHandle.h
//  Honey
//
//  Created by 李高锋 on 2017/9/28.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FilerNameUntil.h"


typedef NS_ENUM(NSUInteger, filter_style) {
    blur_style_guess = 0,//高斯模糊
    blur_style_boxBlur = 1,//均值模糊
    blur_style_motionBlur = 2,//动态模糊
    
    //....plus anthers
};

@interface GAImageFilterHandle : NSObject

+ (NSArray *)allFileter;

+ (void)defaultImage:(UIImage *)image type:(filter_style)style imageView:(UIImageView *)imageView nameLable:(UILabel *)nameLable;

+ (UIImage *)image:(UIImage *)image blurStyle:(filter_style)style blurRadious:(CGFloat)radious blurParam:(id)param;

// and anthers
@end
