//
//  GACameraFilterModel.h
//  Honey
//
//  Created by 李高锋 on 2017/7/5.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+ImageUtils.h"



@interface GACameraBaseFilterModel : NSObject

+ (NSString *)filterName;

+ (UIImage *)defaultImageWithImage:(UIImage *)image;

// only blur filter have this!
+ (UIImage *)image:(UIImage *)image blurRadious:(CGFloat)radious blurParam:(id)param;


@end
