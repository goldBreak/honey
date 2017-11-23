//
//  ViewController.m
//  Honey
//
//  Created by 李高锋 on 16/9/22.
//  Copyright © 2016年 GaoF. All rights reserved.
//

#import "ViewController.h"

#import "GACameraViewController.h"
#import "GAPhotosHandleViewController.h"
#import "GAGPUCameraViewController.h"
#import "UIImage+Utils.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
    
    self.view.layer.contents = (__bridge id _Nullable)([UIImage timeImage].CGImage);
    
    UIButton *gotoCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    gotoCamera.frame = CGRectMake(0, 0, 100, 50);
    gotoCamera.backgroundColor = [UIColor lightGrayColor];
    gotoCamera.layer.masksToBounds = YES;
    gotoCamera.layer.cornerRadius = 3.0;
    [gotoCamera setTitle:@"照相机" forState:UIControlStateNormal];
    [gotoCamera setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [gotoCamera addTarget:self action:@selector(gotoCamera:) forControlEvents:UIControlEventTouchUpInside];
    gotoCamera.center = self.view.center;
    [self.view addSubview:gotoCamera];
    
    CGRect frame = gotoCamera.frame;
    frame.origin.y += gotoCamera.frame.size.height + 40;
    
    UIButton *gotoImageHandle = [UIButton buttonWithType:UIButtonTypeCustom];
    gotoImageHandle.frame = frame;
    gotoImageHandle.backgroundColor = [UIColor lightGrayColor];
    gotoImageHandle.layer.masksToBounds = YES;
    gotoImageHandle.layer.cornerRadius = 3.0;
    [gotoImageHandle setTitle:@"照片" forState:UIControlStateNormal];
    [gotoImageHandle setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [gotoImageHandle addTarget:self action:@selector(gotoImageLibrary:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:gotoImageHandle];
    
}


- (void)gotoCamera:(UIButton *)button {
    
    GAGPUCameraViewController *cameraVC = [[GAGPUCameraViewController alloc] init];
    [self.navigationController pushViewController:cameraVC animated:YES];
}

- (void)gotoImageLibrary:(UIButton *)button {
    
    GAPhotosHandleViewController *photosHandle = [[GAPhotosHandleViewController alloc] init];
    [self.navigationController pushViewController:photosHandle animated:NO];
}

@end
