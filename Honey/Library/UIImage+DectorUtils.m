//
//  UIImage+DectorUtils.m
//  test
//
//  Created by 李高锋 on 16/9/22.
//  Copyright © 2016年 Gaof. All rights reserved.
//

#import "UIImage+DectorUtils.h"
#import "CIImage+DectorUtils.h"

@implementation UIImage (DectorUtils)

- (NSArray *)getFacePropertys {
    
    return [[self ciimage] getFacePropertys];
}

#pragma mark - 公共模块
- (CIImage *)ciimage {
    
    CIImage *returnImage = self.CIImage;
    if (nil == returnImage) {
        CGImageRef imageRef = self.CGImage;
        returnImage = [CIImage imageWithCGImage:imageRef];
    }
    return returnImage;
}

@end
