//
//  CIImage+DectorUtils.h
//  test
//
//  Created by 李高锋 on 16/9/22.
//  Copyright © 2016年 Gaof. All rights reserved.
//

#import <CoreImage/CoreImage.h>
@import UIKit;

@interface CIImage (DectorUtils)

/**
 *  脸部数据获取
 *
 *  @return
 */
- (NSArray *)getFacePropertys;




#pragma mark - 公共模块
/**
 *  @author Gaof, 16-07-20 15:07:25
 *
 *  转换成UIImage
 *
 *  @return UIImage
 */
- (UIImage *)dealImage;

@end
