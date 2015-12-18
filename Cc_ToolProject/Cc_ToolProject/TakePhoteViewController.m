//
//  TakePhoteViewController.m
//  CameDemo
//
//  Created by cchuan on 15/12/8.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import "TakePhoteViewController.h"
#import "CaptureSessionManager.h"

@interface TakePhoteViewController ()<CaptureSessionManagerDelegate>

@property (nonatomic, strong) CaptureSessionManager *captureManager;
@property (nonatomic, assign) BOOL isFront;

@property (nonatomic, assign) CGRect layerFrame;

@end

@implementation TakePhoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 默认开启后面摄像头
    self.isFront = NO;
    self.captureManager = [[CaptureSessionManager alloc] init];
    self.captureManager.delegate = self;
    [self.captureManager addVideoInputFrontCamera:self.isFront];
    [self.captureManager addVideoPreviewLayer];
    [self.captureManager addStillImageOutput];
    
    self.captureManager.previewLayer.frame = CGRectMake(20.0, 100.0, 150, 350);
    self.layerFrame = self.captureManager.previewLayer.frame;
    // 使用xib创建时，如果直接使用addSublayer，会遮挡xib上自定义的控件
    // [self.view.layer addSublayer:self.captureManager.previewLayer];
    [self.view.layer insertSublayer:self.captureManager.previewLayer atIndex:0];
    
    [self.captureManager.captureSession startRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeButtonClick:(id)sender
{
    [self.captureManager swapFrontAndBackCameras];
}

- (IBAction)takePhotoButtonClick:(id)sender
{
    [self.captureManager captureTakePhoto];
}

- (void)captureSessionManagerResultImage:(UIImage *)image
{
    NSLog(@"image size:(%f,%f) %f", image.size.width, image.size.height , image.size.height/image.size.width);
    if (image == nil) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(resultImage:)]) {
        [self.delegate resultImage:image];
    }
}

@end
