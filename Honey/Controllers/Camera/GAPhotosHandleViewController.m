//
//  GAPhotosHandleViewController.m
//  Honey
//
//  Created by 李高锋 on 16/10/10.
//  Copyright © 2016年 GaoF. All rights reserved.
//

#import "GAPhotosHandleViewController.h"
#import "UIImage+DectorUtils.h"
#import "UIImage+ImageUtils.h"

typedef void(^custormerBlock)(int i,int y);

@interface GAPhotosHandleViewController ()

@property (nonatomic, strong) UIImageView *lastShowImageView;
@property (nonatomic, copy) custormerBlock block;

@end

@implementation GAPhotosHandleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"test.jpg"];
   
    
    CGFloat scale = ScreenWidth / image.size.width ;
    self.lastShowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, image.size.height * scale)];
    
    [self.view addSubview:self.lastShowImageView];
    
//    GPUImageBeautifyFilter 
    
//    NSArray *array = [image getFacePropertys];
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformScale(transform, 1, -1);
//    transform = CGAffineTransformTranslate(transform, 0, -image.size.height);
//    for (CIFaceFeature *face in array) {
//        CGRect frame = face.bounds;
//        frame = CGRectApplyAffineTransform(frame, transform);
//        UIView *view = [self viewWithFrame:frame scale:scale];
//        [self.lastShowImageView addSubview:view];
//    }
//    image = [[image noirEffectImage] edgedJudgeWithInstance:0.5];
    /* */
    
    self.lastShowImageView.image = image;
}


- (UIView *)viewWithFrame:(CGRect)frame scale:(CGFloat)scale {
    
    
    frame.origin.x *= scale;
    frame.origin.y *= scale;
    frame.size.width *= scale;
    frame.size.height *= scale;
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    view.layer.borderColor = [UIColor greenColor].CGColor;
    view.layer.borderWidth = 0.5;
    
    return view;
}
@end
