//
//  NSString+Wrapper.h
//  MeMeDai
//
//  Created by Jerry.li on 15/5/5.
//  Copyright (c) 2015年 memedai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Wrapper)

/**
 *  验证字符串是否为空
 *
 *  @return true/false
 */
- (BOOL) isNullOrEmpty;

/**
 *  验证字符串是否为字符串空
 *
 *  @return
 */
- (BOOL) isEmpty;

/**
 *  验证字符串是否为NULL
 *
 *  @return
 */
- (BOOL) isNULL;

/**
 *  移除字符串首尾空格
 *
 *  @return 移除首尾空格后的字符串
 */
- (NSString *) trim;

/**
 *  替换原字符串
 *
 *  @param origin      原字符串
 *  @param replacement 替换的字符串
 *
 *  @return 替换后的字符串
 */
- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement;

/**
 *  按指定字符分割字符串
 *
 *  @param separator 指定字符串
 *
 *  @return
 */
- (NSArray *) split:(NSString*) separator;

- (NSString *) toLowerCase;

- (NSString *) toUpperCase;

- (BOOL) equals:(NSString*) anotherString;

- (NSString *) substringFromIndex:(int)beginIndex toIndex:(int)endIndex;

//手机号码中间4位打星号 ****
- (NSString *)handlePhoneNumber;

//检测支付密码是否合法
- (BOOL)checkPayForPWD;

//检测登录密码是否合法
- (int)checkLoginPWD;


/**
 *  每隔4位加一个空格
 *
 *  @return 处理后的数据
 */
- (NSString *)addSpaceBlank;


/**
 sha1加密算法
 
 @return 加密后的数据
 */
- (NSString *)sha1;


/**
 处理成为正确的图片URL

 @return 正确的URL
 */
- (NSString *)handleForImageUrlWithTag:(NSInteger)tag;


/**
 处理成为cms图片路径

 @return 正确的图片路径
 */
- (NSString *)handleForCmsImageUrl;

/**
 字符串转成NSDate

 @param format 格式
 @return 格式生成后的NSDate
 */
- (NSDate *)handleToDateByFormat:(NSString *)format;


@end
