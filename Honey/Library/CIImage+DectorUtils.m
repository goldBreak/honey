//
//  CIImage+DectorUtils.m
//  test
//
//  Created by 李高锋 on 16/9/22.
//  Copyright © 2016年 Gaof. All rights reserved.
//

#import "CIImage+DectorUtils.h"

@implementation CIImage (DectorUtils)


- (NSArray *)getFacePropertys {
    
    CIContext *content = [CIContext contextWithOptions:NULL];
    CIDetector *dector = [CIDetector detectorOfType:CIDetectorTypeFace context:content options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *faceFeatures = [dector featuresInImage:self];
    
    return faceFeatures;
}


#pragma mark - 公共模块
- (UIImage *)dealImage {
    
    //    UIImage *image = [UIImage imageWithCIImage:self];// scale:0.5 orientation:UIImageOrientationUp
    //    return image;
    
    CIContext *content = [CIContext contextWithOptions:nil];
    CGImageRef ref = [content createCGImage:self fromRect:self.extent];
    
    return  [UIImage imageWithCGImage:ref];
}

@end
