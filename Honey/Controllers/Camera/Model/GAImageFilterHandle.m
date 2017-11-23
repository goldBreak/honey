//
//  GAImageFilterHandle.m
//  Honey
//
//  Created by 李高锋 on 2017/9/28.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "GAImageFilterHandle.h"

@implementation GAImageFilterHandle

+ (NSArray *)allFileter {
    
    return @[
             @(blur_style_guess),
             @(blur_style_boxBlur),
             @(blur_style_motionBlur)
             ];
}

+ (void)defaultImage:(UIImage *)image type:(filter_style)style imageView:(UIImageView *)imageView nameLable:(UILabel *)nameLable {
   
    switch (style) {
        case blur_style_guess:
            NSLog(@"%@",[GAGuessBlurFileterModel filterName]);
            imageView.image = [GAGuessBlurFileterModel defaultImageWithImage:image];
            nameLable.text = [GAGuessBlurFileterModel filterName];
            break;
            
        case blur_style_boxBlur:
            
            imageView.image = [GABoxBlurFilterModel defaultImageWithImage:image];
            nameLable.text = [GABoxBlurFilterModel filterName];
            break;
            
        case blur_style_motionBlur:
            
            imageView.image = [GAMotionBlurFileterModel defaultImageWithImage:image];
            nameLable.text = [GAMotionBlurFileterModel filterName];
            
            break;
        
        default:
            imageView.image = [GAGuessBlurFileterModel defaultImageWithImage:image];
            nameLable.text = [GAGuessBlurFileterModel filterName];
            break;
    }

}

+ (UIImage *)image:(UIImage *)image blurStyle:(filter_style)style blurRadious:(CGFloat)radious blurParam:(id)param {
    
    switch (style) {
        case blur_style_guess:
            return [GAGuessBlurFileterModel image:image blurRadious:radious blurParam:param];
            break;
            
        case blur_style_boxBlur:
            return [GABoxBlurFilterModel image:image blurRadious:radious blurParam:param];
            break;
            
        case blur_style_motionBlur:
            return [GAMotionBlurFileterModel image:image blurRadious:radious blurParam:param];
            break;
        default:
            break;
    }
    
    return [GAGuessBlurFileterModel defaultImageWithImage:image];
}



@end
