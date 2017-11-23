//
//  GACustomerSlider.m
//  Honey
//
//  Created by 李高锋 on 2017/7/5.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "GACustomerSlider.h"

@implementation GACustomerSlider

- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenWidth - 30, 14.)];
        _nameLable.textAlignment = NSTextAlignmentCenter;
        _nameLable.textColor = [UIColor blackColor];
        _nameLable.font = [UIFont systemFontOfSize:13.];
    }
    return _nameLable;
}

- (UISlider *)silder {
    if (!_silder) {
        _silder = [[UISlider alloc] initWithFrame:CGRectMake(15, 24., ScreenWidth - 30, 15)];
        _silder.minimumValue = 1;
        
    }
    return _silder;
}


@end
