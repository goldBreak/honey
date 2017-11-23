//
//  GAEffectView.m
//  Honey
//
//  Created by 李高锋 on 2017/7/4.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "GAEffectView.h"


@interface  GAEffectView()



@end

@implementation GAEffectView


- (instancetype)initWithOrigin:(CGPoint)origin
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, cellWidth, cellWidth)];
    if (self) {
        [self addSubview:self.effectName];
        [self addSubview:self.effectImage];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.effectImage];
        
        [self addSubview:self.effectName];
        
    }
    return self;
}

#pragma mark - lazy
- (UIImageView *)effectImage {
    if (!_effectImage) {
        _effectImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _effectImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return  _effectImage;
}

- (UILabel *)effectName {
    
    if (!_effectName) {
        _effectName = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 13, self.width, 12.)];
        _effectName.font = [UIFont systemFontOfSize:12.];
        _effectName.textColor = [UIColor whiteColor];
        _effectName.textAlignment = NSTextAlignmentCenter;
        
    }
    return _effectName;
}
@end
