//
//  StringUtils.h
//  Memedai
//
//  Created by Jerry.li on 15/12/30.
//  Copyright © 2015年 memedai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

/**
 *  检验字符串是否为空
 *
 *  @param str
 *
 *  @return
 */
+ (BOOL)isNullOrEmpty:(NSString *)str;

/**
 *  分割字符串
 *
 *  @param string  需要分割的字符串
 *  @param separator 指定分割字符
 *
 *  @return
 */
+ (NSArray *)split:(NSString *) string separator:(NSString *)separator;

/**
 *  校验字符串根据正则表达式
 *
 *  @param string 需要校验的字符串
 *  @param regx   正则表达式
 *
 *  @return
 */
+ (BOOL)verifyString:(NSString *)string regx:(NSString *)regx;

/**
 *  把NSDate转换成为字符串
 *
 *  @param date      时间
 *  @param formettle 格式
 *
 *  @return 
 */
+ (NSString *)stringFromeDate:(NSDate *)date andFormettle:(NSString *)formettle;

/**
 *  是否包含特殊字符
 *
 *  @param string 要验证的字符串
 */
+ (BOOL)isIncludeSpecialCharacter:(NSString *)string;

/**
 *  是否包含数字
 *
 *  @param string 要验证的字符串
 *
 *  @return
 */
+ (BOOL)isIncludeNum:(NSString *)string;

/**
 *  是否包含字母
 *
 *  @param string 要验证的字符串
 *
 *  @return 
 */
+ (BOOL)isIncludeCharacter:(NSString *)string;

/**
 *  过滤表情
 *
 *  @param string 要验证的字符串
 *
 *  @return 
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

/**
 *  获取字符串长度，中文按照2个字节计算
 *
 *  @param string
 *
 *  @return
 */
+ (int)getStringLength:(NSString *)string;

/**
 *  将服务器返回的int数值转换为金额格式 x,xxx.xx
 *  获取字符串长度，对双字符（包括汉字）按两位计数
 *
 *  @param number int数值（因为服务器返回来的都是nsvalue，或者nsnumber 所以用id 比较合适）
 *
 *  @return 格式为x,xxx.xx的金额
 *  @return
 */
+ (NSString *)convertAmountWithIntValue:(id)number;

/**
 *  将服务器返回的double数值转换为金额格式 ￥x,xxx.xx
 *
 *  @param number double数值（因为服务器返回来的都是nsvalue，或者nsnumber 所以用id 比较合适）
 *
 *  @return 格式为￥x,xxx.xx的金额
 */
+ (NSString *)convertAmountWithDoubleValue:(id)number;

/**
 *  将阿拉伯数字转换为中文数字
 *
 *  @param arebic 阿拉伯数字字符串
 *
 *  @return 转换后的中文数字
 */
+ (NSString *)translationToChinaeseWithNumber:(NSInteger)arebic;

/**
 *  转换NULL或者nil为@“”
 *
 *  @param string
 *  @param defaultString 默认字符串
 *
 *  @return
 */
+ (NSString *)convertNUL:(NSString *)string defaultString:(NSString *)defaultString;


/**
 将字典转成json字符串

 @param dict 字典
 @return 字符串
 */
+ (NSString *)jsonStringFromDictorary:(id)object;
@end
