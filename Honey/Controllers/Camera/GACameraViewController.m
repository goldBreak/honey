//
//  GACameraViewController.m
//  Honey
//
//  Created by 李高锋 on 16/9/22.
//  Copyright © 2016年 GaoF. All rights reserved.
//

#import "GACameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+ImageUtils.h"
#import "CIImage+ImageUtils.h"
#import "GPUImageBeautifyFilter.h"

@interface GACameraViewController ()
<
    AVCaptureVideoDataOutputSampleBufferDelegate
>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVCaptureDevice *backCaptionDive;
@property (nonatomic, strong) AVCaptureDevice *frontCaptionDive;
@property (nonatomic, strong) AVCaptureDevice *captionDive;

@property (nonatomic, strong) AVCaptureDeviceInput *backInputDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *frontInputDevice;

@property (nonatomic, strong) CALayer *customerPreLayer;
//@property (nonatomic, strong) AVCaptureMetadataOutput *captureMetadataOutput;//输出数据

@property (nonatomic, strong) AVCaptureVideoDataOutput *captureOutput ;

@property (nonatomic, assign) BOOL isReady;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL isBackCamrea;

@end

@implementation GACameraViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    _isReady = YES;
    self.selected = NO;
    self.isBackCamrea = YES;
    
    [self initToolBar];
    [self initControl];
    
}


- (void)initControl {
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    NSError *error;
    for (AVCaptureDevice *device in devices) {
        if (device.position == AVCaptureDevicePositionBack) {
            _backCaptionDive = device;
            _backInputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        }
        if (device.position == AVCaptureDevicePositionFront) {
            _frontCaptionDive = device;
            _frontInputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        }
    }
    _captionDive = _frontCaptionDive;
    
    if (!_backInputDevice) {
        _isReady = NO;
        return;
    }
    
    _captureSession         = [[AVCaptureSession alloc] init];
    [_captureSession setSessionPreset:AVCaptureSessionPresetPhoto];

    dispatch_queue_t dispatchQueue = dispatch_queue_create("myQueue", NULL);
    
    _captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    _captureOutput.alwaysDiscardsLateVideoFrames = YES;
    
    [_captureOutput setSampleBufferDelegate:self queue:dispatchQueue];
    
    [_captureSession addInput:_backInputDevice];
    [_captureSession addOutput:_captureOutput];

//    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
//    [_videoPreviewLayer setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    
//    [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    
    _customerPreLayer = [CALayer layer];

    _customerPreLayer.frame = CGRectMake(0, 0, ScreenWidth,ScreenHeight);
//    _customerPreLayer.affineTransform = CGAffineTransformMakeRotation(M_PI_2);
//    _customerPreLayer.fillMode = UIViewContentModeScaleAspectFit;
    [self.view.layer insertSublayer:_customerPreLayer atIndex:0];
}

#pragma mark - local
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    /*
     *还原原来的系统
     */
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    if (self.captureSession) {
        [self.captureSession stopRunning];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_isReady) {
        return;
    }
    
    if (self.captureSession) {
        [self.captureSession startRunning];
    }
    
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
    
    
}

// 前后摄像头切换
- (void)switchCameraBtn:(UIButton *)button {
    
    self.isBackCamrea = !self.isBackCamrea;
    
    if (self.isBackCamrea) {
        
        [self.captureSession beginConfiguration];
        [self.captureSession removeInput:_frontInputDevice];
        [self.captureSession addInput:_backInputDevice];
        [self.captureSession commitConfiguration];
        
        _captionDive = _backCaptionDive;
        
    }else {
        [self.captureSession beginConfiguration];
        [self.captureSession removeInput:_backInputDevice];
        [self.captureSession addInput:_frontInputDevice];
        [self.captureSession commitConfiguration];
        
        _captionDive = _frontCaptionDive;
    }
    
}

- (void)lightBtnAction:(UIButton *)Btn {
    //普通开关模式
    self.selected = !self.selected;
    if(self.selected)
    {
        //打开闪光灯
        if([self.captionDive hasTorch] && [self.captionDive hasFlash])
        {
            if(self.captionDive.torchMode == AVCaptureTorchModeOff)
            {
                [self.captureSession beginConfiguration];
                [self.captionDive lockForConfiguration:nil];
                [self.captionDive setTorchMode:AVCaptureTorchModeOn];
                [self.captionDive setFlashMode:AVCaptureFlashModeOn];
                [self.captionDive unlockForConfiguration];
                [self.captureSession commitConfiguration];
            }
        }
    }
    else
    {
        //关闭闪光灯
        [self.captureSession beginConfiguration];
        [self.captionDive lockForConfiguration:nil];
        if(self.captionDive.torchMode == AVCaptureTorchModeOn)
        {
            [self.captionDive setTorchMode:AVCaptureTorchModeOff];
            [self.captionDive setFlashMode:AVCaptureFlashModeOff];
        }
        [self.captionDive unlockForConfiguration];
        [self.captureSession commitConfiguration];
    }
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
    //不要这么频繁，CPU、GPU都受不了，可以先弄简单点的，在图片生成的时候进行精细的操作
    //这儿尽量的节省内存空间...毕竟太大了，图片太大了...太耗资源了
    
    UIImage *image = [self gpuImage:[self getImageByData:sampleBuffer]];

    [self.customerPreLayer performSelectorOnMainThread:@selector(setContents:) withObject:(__bridge id _Nullable)image.CGImage waitUntilDone:YES];

//    [self.customerPreLayer performSelectorOnMainThread:@selector(setContents:) withObject:(__bridge id _Nullable)([self imageFaceReconsin:sampleBuffer]) waitUntilDone:YES];
}

- (UIImage *)getImageByData:(CMSampleBufferRef)sampleBuffer {
  
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *ciImage = [CIImage imageWithCVImageBuffer:imageBuffer];
    ciImage = [ciImage bumpDistortionWithCenter:CGPointMake(400, 350) andRadous:200 andScale:0.5];//noirEffectImage];
    
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
    CGImageRef videoImage = [temporaryContext createCGImage:ciImage fromRect:CGRectMake(0, 0, CVPixelBufferGetWidth(imageBuffer), CVPixelBufferGetHeight(imageBuffer))];
    
    UIImageOrientation option = UIImageOrientationRight;
    if(!self.isBackCamrea) {
        option = UIImageOrientationLeftMirrored;
    }
    UIImage *result = [[UIImage alloc] initWithCGImage:videoImage scale:1.0 orientation:option];
    CGImageRelease(videoImage);
    
    return result;

}


- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - GPUImage
- (UIImage *)gpuImage:(UIImage *)image {
    
//    GPUImageHalftoneFilter *filter = [[GPUImageHalftoneFilter alloc] init];
//    [filter forceProcessingAtSize:image.size];
//    [filter useNextFrameForImageCapture];
//    
//    GPUImagePicture *imageSOurce = [[GPUImagePicture alloc] initWithImage:image];
//    [imageSOurce addTarget:filter];
//    [imageSOurce processImage];
    
    GPUImageBeautifyFilter *gpuFilter = [[GPUImageBeautifyFilter alloc] init];
    [gpuFilter forceProcessingAtSize:image.size];
    [gpuFilter useNextFrameForImageCapture];
    
    GPUImagePicture *imageSource = [[GPUImagePicture alloc] initWithImage:image];
    [imageSource addTarget:gpuFilter];
    [imageSource processImage];
    UIImage *outPutImage = [gpuFilter imageFromCurrentFramebuffer];
    
    return outPutImage;
}



#pragma mark - face reconsign
- (CGImageRef)imageFaceReconsin:(CMSampleBufferRef)sampleBuffer {
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *ciImage = [CIImage imageWithCVImageBuffer:imageBuffer];
    return [ciImage dealImage].CGImage;
}

@end
