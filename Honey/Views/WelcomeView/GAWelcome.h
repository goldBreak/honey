//
//  GAWelcome.h
//  Honey
//
//  Created by 李高锋 on 16/10/30.
//  Copyright © 2016年 GaoF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAWelcome : UIView


/**
 显示欢迎页面

 @param showView 要显示的页面
 @param duration 移除的时间
 */
+ (void)showWelcomeOnView:(UIView *)showView removeAfterDuration:(NSTimeInterval)duration;

/**
 *  创建雪花场景
 */
- (void)createSense;

/**
 *  开始雪花动画
 */
- (void)maskAnimation;
@end
