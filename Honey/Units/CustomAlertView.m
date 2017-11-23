//
//  CustomAlertView.m
//  Memedai
//
//  Created by wgs on 16/1/19.
//  Copyright © 2016年 memedai. All rights reserved.
//

#import "CustomAlertView.h"

static CGFloat const TOASTWIDTH = 270;//Toast弹出框宽度
static CGFloat const TOAST_LR_SPACE = 17.0;//Toast左右边距
static CGFloat const TOAST_UD_SPACE = 12.0;//Toast上下边距
static CGFloat const TOAST_DURATION = 1.5;//Toast弹框默认显示时间

typedef NS_ENUM(NSInteger, AlertViewType){
    AlertViewTypeToast,
    AlertViewTypeAlert
};

@interface CustomAlertView()<CAAnimationDelegate>

@property (nonatomic ,copy)   NSString         *message;
@property (nonatomic ,assign) AlertViewType    alertType;
@property (nonatomic ,strong) UIView           *alertView;
@property (nonatomic, strong) UIView           *superView;

@end

@implementation CustomAlertView

- (instancetype)initWithToastMessage:(NSString *)message delegate:(id<CustomAlertViewDelegate>)delegate{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        
        self.message = message;
        self.delegate = delegate;
        self.alertType = AlertViewTypeToast;
        self.duration = TOAST_DURATION;
    }
    return self;
}

- (instancetype)initWithVerticalToastMessage:(NSString *)message delegate:(id<CustomAlertViewDelegate>)delegate{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        
        self.message = message;
        self.delegate = delegate;
        self.alertType = AlertViewTypeToast;
        self.duration = TOAST_DURATION;
    }
    return self;
}

//TODO: 弹出提示框
- (void)showAlertViewOn:(UIView *)showView{
    _superView = showView;
    if (self.alertType == AlertViewTypeToast) {
        
        [showView addSubview:self];
        [self addSubview:self.alertView];
        [self exChangeOut:self.alertView dur:0.3f];
    }
}

//TODO: 隐藏提示框
- (void)dismissAlertView{
    
    if (self.alertType == AlertViewTypeToast) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.alertView.alpha = 0;
        } completion:^(BOOL finished) {
            
            if([self.delegate respondsToSelector:@selector(alertViewToastDismissed:)]){
                [self.delegate alertViewToastDismissed:self];
            }
            [self removeFromSuperview];
        }];
    }
}

//TODO: 绘制Toast弹出框
- (void)creatToastView{
    
    if ([StringUtils isNullOrEmpty:self.message]) {
        return;
    }
    
    CGSize size = [self.message boundingRectWithSize:CGSizeMake(TOASTWIDTH - TOAST_LR_SPACE*2, 99) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.]} context:nil].size;
    _alertView.bounds = CGRectMake(0, 0, size.width + 2 * TOAST_LR_SPACE, TOAST_UD_SPACE * 2 + size.height);
    
    UILabel * messageLable     = [[UILabel alloc] initWithFrame:CGRectMake(TOAST_LR_SPACE, TOAST_UD_SPACE, _alertView.frame.size.width - TOAST_LR_SPACE * 2, size.height)];
    messageLable.numberOfLines = 2;
    messageLable.font          = [UIFont systemFontOfSize:13.];
    messageLable.textColor     = [UIColor whiteColor];
    messageLable.text          = self.message;
    messageLable.textAlignment = NSTextAlignmentCenter;
    messageLable.backgroundColor = [UIColor clearColor];
    [_alertView addSubview:messageLable];
}

//TODO: 弹出框动画
- (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dur;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:@"toast"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if ([self.alertView.layer animationForKey:@"toast"] == anim) {
        [self performSelector:@selector(dismissAlertView) withObject:nil afterDelay:_duration];
    }
}

- (void)setDuration:(CGFloat)duration{
    _duration = duration;
}

- (UIView *)alertView{
    
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.alpha = 1.0;
        _alertView.center = self.center;
        _alertView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];// [UIColor colorWithHexString:@"#000000" andAlpha:0.6];
        if (_superView.frame.size.height != ScreenHeight) {
            _alertView.center = CGPointMake(self.center.x, self.center.y - 64);
        }
        _alertView.layer.cornerRadius = 6.0;
        _alertView.layer.masksToBounds = YES;
        
        if (self.alertType == AlertViewTypeToast) {
            [self creatToastView];
        }
        
        if (self.alertType == AlertViewTypeAlert) {
            
        }
    }
    return _alertView;
}


@end
