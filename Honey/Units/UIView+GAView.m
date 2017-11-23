//
//  UIView+GAView.m
//  Honey
//
//  Created by 李高锋 on 2017/7/31.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "UIView+GAView.h"

@implementation UIView (GAView)

- (CGFloat)width {
    
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (CGFloat)originx {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)originy {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

@end
