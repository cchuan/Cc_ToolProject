//
//  CaptureSessionManager.h
//  CameDemo
//
//  Created by cchuan on 15/12/8.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVCaptureVideoPreviewLayer.h>
#import <AVFoundation/AVCaptureSession.h>
#import <AVFoundation/AVCaptureInput.h>
#import <AVFoundation/AVCaptureOutput.h>
#import <AVFoundation/AVVideoSettings.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVAudioSession.h>

#import <ImageIO/ImageIO.h>

@protocol CaptureSessionManagerDelegate <NSObject>

- (void)captureSessionManagerResultImage:(UIImage *)image;

@end

@interface CaptureSessionManager : NSObject<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, assign) id<CaptureSessionManagerDelegate>delegate;

@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;

@property (retain) AVCaptureStillImageOutput *stillImageOutput;
@property (retain) AVCaptureVideoDataOutput *videoOutput;

- (void)addVideoPreviewLayer;

- (void)addStillImageOutput;
- (void)removeStillImageOutput;
- (void)captureTakePhoto;


- (void)addVideoInputFrontCamera:(BOOL)front;
// 切换前后摄像头
- (void)swapFrontAndBackCameras;

@end
