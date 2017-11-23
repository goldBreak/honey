//
//  NSString+Wrapper.m
//  MeMeDai
//
//  Created by Jerry.li on 15/5/5.
//  Copyright (c) 2015年 memedai. All rights reserved.
//

#import "NSString+Wrapper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Wrapper)

- (BOOL) isNullOrEmpty {
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (self == nil || self == NULL || [self isEqualToString:@""]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

- (BOOL) isEmpty {
    if (self == nil || [self length] == 0) {
        return YES;
    }
    return NO;
}

- (BOOL) isNULL {
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}


- (NSString *) trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *) replaceAll:(NSString*)origin with:(NSString*)replacement {
    return [self stringByReplacingOccurrencesOfString:origin withString:replacement];
}

- (NSArray *) split:(NSString*) separator {
    return [self componentsSeparatedByString:separator];
}

- (NSString *) toLowerCase {
    return [self lowercaseString];
}

- (NSString *) toUpperCase {
    return [self uppercaseString];
}

- (BOOL) equals:(NSString*) anotherString {
    return [self isEqualToString:anotherString];
}

- (NSString *) substringFromIndex:(int)beginIndex toIndex:(int)endIndex {
    if ([self isNullOrEmpty]) {
        return @"";
    }
    if (beginIndex >= endIndex) {
        return @"";
    }
    NSRange range = NSMakeRange(beginIndex, endIndex - beginIndex);
    return [self substringWithRange:range];
}

- (NSString *)handlePhoneNumber
{
    NSString * string = [NSString stringWithFormat:@"%@***%@",[self substringToIndex:4],[self substringFromIndex:7]];
    return string;
}

- (BOOL)checkPayForPWD{
    
   
    NSString * string = [self trim];
    //判断字符长度！
    if (string.length != 6) {
        return NO;
    }

    const char *c = [string UTF8String];

    int i = 1;
    
    BOOL isEqual = YES;
    BOOL isPlus  = YES;
    BOOL isSubtract = YES;
    
    //判断相同
    while (c[i] != '\0') {
        if (c[i] != c[i-1]) {
            isEqual = NO;
        }
        if (c[i] != c[i-1] - 1) {
            isSubtract = NO;
        }
        if (c[i] != c[i-1] + 1) {
            isPlus = NO;
        }
        i++;
    }
    
    return !isEqual && !isPlus && !isSubtract;
}

- (int)checkLoginPWD{
    //如果是0，正确的密码组合
    //如果是1，密码个数不达标
    //如果是2，数字和字母的组合
    //如果是3，简单密码
    
    int returnValue = 0;
    
    NSString * string = [self trim];

    //判断字符长度！
    if (string.length < 8 || string.length > 16) {
        returnValue = 1;
        return returnValue;
    }
    
    const char *c = [string UTF8String];
    
    if (![self isNumberAndCharCompelted:c]) {
        
        return 2;
    }
    
    if (![self isComplexCompelted:c]) {

        return 3;
    }
    
    return returnValue;
}

//数字和字母的组合
- (BOOL)isNumberAndCharCompelted:(const char *)testCharList{
    
    int i = 0;
    char testC = testCharList[i];
    
    BOOL isAllNumber = YES;
    BOOL isAllChar   = YES;
    BOOL isSpecial   = NO;
    
    
    while (testC != '\0') {

        if (testC <= '9' && testC >= '0'){
            
            isAllChar = NO;
        }else if ((testC >= 'A' && testC <= 'Z') || (testC >= 'a' && testC <= 'z')){
            
            isAllNumber = NO;
        }else{
            
            isSpecial = YES;
            return NO;
            break;
        }
        
        testC = testCharList[++i];
    }
    
    if (isAllNumber || isAllChar) {
        
        return NO;
    }
    
    return YES;
}

//检测是不是复杂组合
- (BOOL)isComplexCompelted:(const char *)testCharList{
    
    int i = 1;
    
    int maxNumberOfDisqualification = 0;
    int upNumbers = 1;
    int downNumbers = 1;
    int equalNumbers = 1;
    
    char nomalChar = testCharList[1];
    char frontChar = testCharList[0];
    
    BOOL isAllEqual = YES;
    

    while (nomalChar != '\0') {

        if (equalNumbers >= 6) {

            return NO;
            break;
        }
        
        if (nomalChar != frontChar) {

            equalNumbers = 1;
            isAllEqual = NO;
            
            if (nomalChar == frontChar + 1) {
                
                if (maxNumberOfDisqualification < downNumbers) {
                    
                    maxNumberOfDisqualification = downNumbers;
                }
                downNumbers = 1;
                upNumbers ++;
                
                if (maxNumberOfDisqualification >= 6) {
                    return NO;
                }
                
            }else if (nomalChar == frontChar - 1){

                if (maxNumberOfDisqualification < upNumbers) {
                    
                    maxNumberOfDisqualification = upNumbers;
                }
                upNumbers = 1;
                downNumbers ++;
                
                if (maxNumberOfDisqualification >= 6) {
                    return NO;
                }

                
            }else{
                
                if (upNumbers < downNumbers) {
                    
                    upNumbers = downNumbers;
                }
                
                if (maxNumberOfDisqualification < upNumbers) {
                    
                    maxNumberOfDisqualification = upNumbers;
                }
                
                if (maxNumberOfDisqualification >= 6) {
                    return NO;
                }

                downNumbers = 1;
                upNumbers   = 1;
            }
            
        }else{
            

            if (upNumbers < downNumbers) {
                
                upNumbers = downNumbers;
            }
            
            if (maxNumberOfDisqualification < upNumbers) {
                
                maxNumberOfDisqualification = upNumbers;
            }
            
            
            if (maxNumberOfDisqualification >= 6) {
                return NO;
            }
  
            downNumbers = 1;
            upNumbers   = 1;
            equalNumbers += 1;
        }
        
        
        frontChar = nomalChar;
        nomalChar = testCharList[++i];
    }
    
 
    return YES;
}

- (NSString *)addSpaceBlank {

    NSString *tempString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (tempString.length <= 4) {
        return tempString;
    }
    NSString *returnString = [tempString substringToIndex:4];
    returnString = [returnString stringByAppendingString:@" "];
    
    for (int i = 4; i < tempString.length; ) {
       
        if (i + 4 >= tempString.length) {
            returnString = [returnString stringByAppendingString:[tempString substringFromIndex:i]];
            break;
        } else {
            NSRange range = NSMakeRange(i, 4);
            returnString = [returnString stringByAppendingString:[tempString substringWithRange:range]];
            returnString = [returnString stringByAppendingString:@" "];
            i= i + 4;
        }
    }

    return returnString;
}

- (NSString *)sha1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)handleForImageUrlWithTag:(NSInteger)tag {
    
    NSString *returnStr = @"FileService/show/";
    returnStr = [returnStr stringByAppendingString:self];
    NSString *tags = @"_m";
    if (tag == 1) {
        tags = @"_s";
    }else if (tag == 2) {
        tags = @"_c";
    }
    returnStr = [returnStr stringByAppendingString:tags];
    
    return returnStr;
}

- (NSString *)handleForCmsImageUrl {
    NSString *returnStr = @"FileService/showQRCode?moduleName=train&fileName=";
    returnStr = [returnStr stringByAppendingString:self];
    return returnStr;
}
- (NSDate *)handleToDateByFormat:(NSString *)format {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}
@end
