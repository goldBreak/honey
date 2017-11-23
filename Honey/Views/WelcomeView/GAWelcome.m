//
//  GAWelcome.m
//  Honey
//
//  Created by 李高锋 on 16/10/30.
//  Copyright © 2016年 GaoF. All rights reserved.
//

#import "GAWelcome.h"
#import "UIImage+Utils.h"

@interface GAWelcome()

@property (nonatomic,strong) CAEmitterLayer *snowEmitter ;
@property (nonatomic,strong) CALayer *maskLayer;
@property (nonatomic, weak) UIView *showView;

@end

@implementation GAWelcome

+ (void)showWelcomeOnView:(UIView *)showView removeAfterDuration:(NSTimeInterval)duration {
    
    GAWelcome *welView = [[GAWelcome alloc] initWithFrame:showView.bounds];
    [showView addSubview:welView];
    [welView performSelector:@selector(removeSelf) withObject:nil afterDelay:duration];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        CATransform3D identty = CATransform3DIdentity;
        identty.m34 = 0.001;
        self.layer.transform = identty;
        
        NSDate * currentDate = [NSDate date];
        NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
        NSDate * newDate = [currentDate dateByAddingTimeInterval:timeZoneOffset];
        NSCalendar * cal= [NSCalendar currentCalendar];
        NSDateComponents * compon = [cal components:NSCalendarUnitYear | kCFCalendarUnitWeek | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:newDate];
        
        self.layer.contents = (__bridge id _Nullable)([UIImage timeImage].CGImage);
        
        switch ([compon month]) {
        
            case 11:
            case 12:
            case 1:
            {
                [self createSense];
            }
                break;
                
            default:
                
                break;
        }
        
        
    }
    return self;
}

- (void)removeSelf {
    
    [self removeFromSuperview];
    
}


- (void)createSense{
    
    _snowEmitter = [CAEmitterLayer layer];
    _snowEmitter.emitterPosition = CGPointMake(ScreenWidth / 2.0, -20);//高空发送雪花❄️
    _snowEmitter.emitterSize = self.bounds.size;
    _snowEmitter.emitterMode = kCAEmitterLayerSurface;
    _snowEmitter.emitterShape = kCAEmitterLayerLine;
    
    CAEmitterCell *snowflake = [CAEmitterCell  emitterCell];
    snowflake.name = @"snow";
    snowflake.birthRate = 5.0;
    snowflake.lifetime = 120.0;
    // 粒子速度
    snowflake.velocity = 20.0;
    
    // 粒子的速度范围
    snowflake.velocityRange = 15;
    
    // 粒子y方向的加速度分量
    snowflake.yAcceleration = 3;
    
    // 周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;
    
    // 子旋转角度范围
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents = (id)[[UIImage imageNamed:@"snow.png"] CGImage];
    
    // 设置雪花形状的粒子的颜色
    snowflake.color = [[UIColor whiteColor] CGColor];
    
    snowflake.scaleRange = 0.6f;
    snowflake.scale = 0.7f;
    
    // 添加粒子
    _snowEmitter.emitterCells = @[snowflake];
    
    // 将粒子Layer添加进图层中
    [self.layer addSublayer:_snowEmitter];
    
}

- (void)maskAnimation {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    /*
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        animation.fromValue = [NSValue valueWithCGRect:weakSelf.maskLayer.bounds];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 50, 50)];
        animation.duration = 3.0;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [weakSelf.maskLayer addAnimation:animation forKey:@"boundsAnimation"];
    */
     UIImage *image = [UIImage imageNamed:@"mask.png"];
     self.maskLayer = [CALayer layer];
     self.maskLayer.frame    = (CGRect){CGPointZero, CGSizeMake(ScreenHeight / 2.0, ScreenHeight / 2.0)};
     self.maskLayer.contents = (__bridge id)(image.CGImage);
     self.maskLayer.position = self.center;
     self.maskLayer.fillMode = kCAFillModeBoth;
     self.snowEmitter.mask = self.maskLayer;
    });
     
}

- (void)animationDidStart:(CAAnimation *)anim {

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //first animation!
}



@end
