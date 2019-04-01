//
//  GAGPUCameraViewController.m
//  Honey
//
//  Created by 李高锋 on 2017/3/17.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "GAGPUCameraViewController.h"
#import <GPUImage.h>
#import "GPUImageBeautifyFilter.h"
#import "GAImageEditView.h"
#import "GAClectionView.h"
#import "CustomAlertView.h"
#import "GAImageFilterHandle.h"

@interface GAGPUCameraViewController ()<imageViewProtocol>

@property (nonatomic, strong) GPUImageStillCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *filterView;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) GPUImageBeautifyFilter *beautifyFilter;

@property (nonatomic, strong) GAImageEditView *imageView;
@property (nonatomic, strong) GAClectionView *clectionView;

@end

@implementation GAGPUCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self initCamera];
    [self initToolBar];
    
}

- (void)initToolBar {
    UIImage *flashImage = [UIImage imageNamed:@"flashlight"];
    UIImage *backImage = [UIImage imageNamed:@"whiteback"];
    
    CGRect frame    = self.navigationController.navigationBar.frame;
    frame.origin.y  = 20;
    UILabel *titleLalbe = [[UILabel alloc] initWithFrame:frame];
    
    
    CGSize size = backImage.size;
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(15, 0, size.width, size.height);
    [buttonBack setBackgroundImage:backImage forState:UIControlStateNormal];
    
    buttonBack.center = CGPointMake(buttonBack.center.x, titleLalbe.center.y);
    [buttonBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBack];
    
    size = flashImage.size;
    UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    frame = CGRectZero;
    frame.size = size;
    frame.origin.x = ScreenWidth - 15 - frame.size.width;
    flashBtn.frame = frame;
    [flashBtn setBackgroundImage:flashImage forState:UIControlStateNormal];
    [flashBtn addTarget:self action:@selector(lightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    flashBtn.center = CGPointMake(flashBtn.center.x, titleLalbe.center.y);
    [self.view addSubview:flashBtn];// addSubview:flashBtn];
    
    UIImage *img = [UIImage imageNamed:@"camera_nomal"];
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    switchBtn.frame = CGRectMake(0, 0, img.size.width, img.size.height);
    [switchBtn setBackgroundImage:img forState:UIControlStateNormal];
    switchBtn.center = CGPointMake(titleLalbe.center.x, titleLalbe.center.y);
    [switchBtn addTarget:self action:@selector(switchCameraBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchBtn];

    UIImage *takePhoto = [UIImage imageNamed:@"cameraIcon"];
    UIButton *takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoBtn.frame = CGRectMake(0, 0, takePhoto.size.width, takePhoto.size.height);
    [takePhotoBtn setImage:takePhoto forState:UIControlStateNormal];
    [takePhotoBtn addTarget:self action:@selector(takePhotoBtnPressDown:) forControlEvents:UIControlEventTouchUpInside];
    takePhotoBtn.center = CGPointMake(ScreenWidth / 2.0, ScreenHeight - takePhotoBtn.bounds.size.height - 30.);
    [self.view addSubview:takePhotoBtn];
}

- (void)initCamera {
    
    self.videoCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.filterView.center = self.view.center;
    
    
    [self.view addSubview:self.filterView];
    [self.videoCamera addTarget:self.filterView];
    [self.videoCamera startCameraCapture];
    
    [self.videoCamera removeAllTargets];
    self.beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
    [self.videoCamera addTarget:self.beautifyFilter];
    [self.beautifyFilter addTarget:self.filterView];
}

#pragma mark - imageViewProtocol

- (void)saveProtocol {
    
    [self savePhoto:self.imageView.showImageView.image];
}

- (void)editProtocol {
    //
    
    [self.view addSubview:self.clectionView];
    self.clectionView.resultArray = [GAImageFilterHandle allFileter];
    self.clectionView.defaultImage = self.imageView.showImageView.image;
}


#pragma mark - Sel
// 前后摄像头切换
- (void)switchCameraBtn:(UIButton *)button {
    
    [self.videoCamera rotateCamera];
}

- (void)lightBtnAction:(UIButton *)Btn {
    //普通开关模式
    
    self.selected = !self.selected;
    if(self.selected)
    {
        //打开闪光灯
        if([self.videoCamera.inputCamera hasTorch] && [self.videoCamera.inputCamera hasFlash])
        {
            if(self.videoCamera.inputCamera.torchMode == AVCaptureTorchModeOff)
            {
                [self.videoCamera.captureSession beginConfiguration];
                [self.videoCamera.inputCamera lockForConfiguration:nil];
                [self.videoCamera.inputCamera setTorchMode:AVCaptureTorchModeOn];
                [self.videoCamera.inputCamera setFlashMode:AVCaptureFlashModeOn];
                [self.videoCamera.inputCamera unlockForConfiguration];
                [self.videoCamera.captureSession commitConfiguration];
            }
        }
    }
    else
    {
        //关闭闪光灯
        [self.videoCamera.captureSession beginConfiguration];
        [self.videoCamera.inputCamera lockForConfiguration:nil];
        if(self.videoCamera.inputCamera.torchMode == AVCaptureTorchModeOn)
        {
            [self.videoCamera.inputCamera setTorchMode:AVCaptureTorchModeOff];
            [self.videoCamera.inputCamera setFlashMode:AVCaptureFlashModeOff];
        }
        [self.videoCamera.inputCamera unlockForConfiguration];
        [self.videoCamera.captureSession commitConfiguration];
    }
    
}


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)takePhotoBtnPressDown:(UIButton *)button {
//    [self.videoCamera photo]
    button.selected = !button.selected ;
    if (button.selected) {
        
        NSLog(@"currendata %@",self.videoCamera.currentCaptureMetadata);
        
        [self.videoCamera capturePhotoAsImageProcessedUpToFilter:self.beautifyFilter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
            if(error){
                return;
            }
            //存入本地相册
            self.imageView.showImageView.image = processedImage;
            [self.view addSubview:self.imageView];
        }];

        
    } else {
        [self.videoCamera resumeCameraCapture];
    }
    
}

#pragma mark - save images
- (void)savePhoto:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinshSavingWithError:contextInfo:), NULL);

}

#pragma mark - Camera save success!
- (void)image:(UIImage *)image didFinshSavingWithError:(NSError *)error contextInfo:(void*)contextInfo {
    
    if (error) {
        [self showToastWithMessage:@"保存失败"];
        
    } else {
        [self showToastWithMessage:@"保存成功"];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.imageView removeFromSuperview];
    });
}

- (GAClectionView *)clectionView {
    if (!_clectionView) {
        _clectionView = [[GAClectionView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, self.imageView.height - 80.)];
    }
    return _clectionView;
}

- (GAImageEditView *)imageView {
    
    if (!_imageView) {
        _imageView = [[GAImageEditView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight - 20)];
        _imageView.delegate = self;
    }
    return _imageView;
}



- (void)showToastWithMessage:(NSString *)message {
    CustomAlertView *alertView = [[CustomAlertView alloc] initWithToastMessage:message delegate:nil];
    [alertView showAlertViewOn:self.view];
}

@end
