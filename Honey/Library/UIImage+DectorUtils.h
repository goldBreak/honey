//
//  UIImage+DectorUtils.h
//  test
//
//  Created by 李高锋 on 16/9/22.
//  Copyright © 2016年 Gaof. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DectorUtils)

//@property (nonatomic, strong) CIContext *content;

/**
 *  脸部数据获取
 *
 *  @return
 */
- (NSArray *)getFacePropertys;


#pragma mark - 公共模块
/**
 *  @author Gaof, 16-07-20 15:07:19
 *
 *  转换成CIImage
 *
 *  @return CIImage
 */
- (CIImage *)ciimage;

@end
