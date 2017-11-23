//
//  CustomAlertView.h
//  Memedai
//
//  Created by wgs on 16/1/19.
//  Copyright © 2016年 memedai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlertView;
@protocol CustomAlertViewDelegate <NSObject>

@optional

- (void)alertViewToastDismissed:(CustomAlertView *)alertView;

@end

@interface CustomAlertView : UIView

@property (nonatomic ,assign)CGFloat   duration;
@property (nonatomic ,weak)id<CustomAlertViewDelegate>delegate;

/**
 *  类似Toast的提示框
 *
 *  @param message  提示内容
 *  @param delegate 代理
 *
 *  @return 类似Toast的提示框
 */
- (instancetype)initWithToastMessage:(NSString *)message delegate:(id<CustomAlertViewDelegate>)delegate;

/**
 *  针对身份证、银行卡横屏拍照提示
 *
 *  @param message  提示内容
 *  @param delegate 代理
 *
 *  @return
 */
- (instancetype)initWithVerticalToastMessage:(NSString *)message delegate:(id<CustomAlertViewDelegate>)delegate;

/**
 *  弹出提示框
 *
 *  @param showView 提示框对应的父视图
 */
- (void)showAlertViewOn:(UIView *)showView;

@end
