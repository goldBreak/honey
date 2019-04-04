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

#import <AssetsLibrary/ALAssetsLibrary.h>
#import <CoreMotion/CMMotionManager.h>
#import "IFlyFaceImage.h"
#import "CanvasView.h"
#import "IFlyFaceResultKeys.h"
#import "CalculatorTools.h"

#import "UIImage+DectorUtils.h"
#import "UIImage+ImageUtils.h"

@interface GAGPUCameraViewController ()<imageViewProtocol,GPUImageVideoCameraDelegate>

@property (nonatomic, strong) GPUImageStillCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *filterView;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) GPUImageBeautifyFilter *beautifyFilter;

@property (nonatomic, strong) GPUImageSobelEdgeDetectionFilter *sobelFilter;

@property (nonatomic, strong) GPUImageSketchFilter *filter;

@property (nonatomic, strong) GAImageEditView *imageView;
@property (nonatomic, strong) GAClectionView *clectionView;

@property (nonatomic, strong) UIImageView *crawImageView;

@property (nonatomic, assign) NSInteger index;

@end

@implementation GAGPUCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self initCamera];
    [self initToolBar];
    
    self.crawImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Crown.png"]];
    self.crawImageView.hidden = YES;
    [self.view insertSubview:self.crawImageView aboveSubview:self.filterView];
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
    
//    self.filter = [[GPUImageGlassSphereFilter alloc] init];
    
//    self.filter = [[GPUImageSketchFilter alloc] init];
//    self.filter.edgeStrength = 2.0;
//    self.filter.texelWidth = 0.5;
//    self.filter.texelHeight = 0.5;
    
    [self.view addSubview:self.filterView];
    [self.videoCamera addTarget:self.filterView];
    [self.videoCamera startCameraCapture];
    
    [self.videoCamera removeAllTargets];
    
//    self.sobelFilter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
//    self.sobelFilter.edgeStrength = 2.0;
//    [self.videoCamera addTarget:self.filter];
//    [self.filter addTarget:self.filterView];
    
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

- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    
    self.index += 1;
    if (self.index != 10) {
        return;
    }
    self.index = 0;
    
    UIImage *currentImage = [self imageFromSampleBuffer:sampleBuffer];
   
    NSArray *array = [currentImage getFacePropertys];

    if (array && array.count > 0) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.crawImageView.hidden = NO;
            
            CGFloat scale = ScreenWidth / currentImage.size.width ;
            
            /*
            CGAffineTransform transform = CGAffineTransformIdentity;
            transform = CGAffineTransformScale(transform, 1, -1);
            transform = CGAffineTransformTranslate(transform, 0, currentImage.size.height);
            CIFaceFeature *face = array.firstObject;
            CGRect frame = face.bounds;
//            frame = CGRectApplyAffineTransform(frame, transform);
            frame = [self viewWithFrame:frame scale:scale];
            
            CGRect imgFrame = self.crawImageView.frame;
            imgFrame.origin.x = frame.origin.x;
            imgFrame.origin.y = frame.origin.y ;//- imgFrame.size.height;
            imgFrame.size.width = frame.size.width;
            imgFrame.size.height = frame.size.width;
            
            self.crawImageView.frame = imgFrame;
             */
//            NSArray *array = [image getFacePropertys];
            CGAffineTransform transform = CGAffineTransformIdentity;
            transform = CGAffineTransformScale(transform, 1, -1);
            transform = CGAffineTransformTranslate(transform, 0, -currentImage.size.height);
            for (CIFaceFeature *face in array) {
                CGRect frame = face.bounds;
                frame = CGRectApplyAffineTransform(frame, transform);
                
                NSLog(@"%@",@(frame));
                
                UIView *sview = [self viewWithFrame:frame scale:scale];
                [self.filterView addSubview:sview];
            }

        });
        
        
    } else {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.crawImageView.hidden = YES;
        });
        
    }
    
}

- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer{
    
    //
//    if (CMSampleBufferIsValid(sampleBuffer)) {
//        return nil;
//    }
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
    
    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    
    UIImage *image = [UIImage imageWithCIImage:ciImage];
    
    return image;
    
    /*
    // 为媒体数据设置一个CMSampleBuffer的Core Video图像缓存对象
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);// 锁定pixel buffer的基地址
    CVPixelBufferLockBaseAddress(imageBuffer, 0);// 得到pixel buffer的基地址
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);// 得到pixel buffer的行字节数
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);// 得到pixel buffer的宽和高
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);// 创建一个依赖于设备的RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();// 用抽样缓存的数据创建一个位图格式的图形上下文（graphics context）对象
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);// 根据这个位图context中的像素数据创建一个Quartz image对象
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);// 解锁pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);// 释放context和颜色空间
    CGContextRelease(context);CGColorSpaceRelease(colorSpace);// 用Quartz image创建一个UIImage对象image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];// 释放Quartz image对象
    CGImageRelease(quartzImage);
    
    return (image);
     */
    
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
