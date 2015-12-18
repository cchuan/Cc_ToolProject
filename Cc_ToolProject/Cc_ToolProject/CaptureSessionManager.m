//
//  CaptureSessionManager.m
//  CameDemo
//
//  Created by cchuan on 15/12/8.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import "CaptureSessionManager.h"

@implementation CaptureSessionManager

- (id)init {
    if ((self = [super init])) {
        self.captureSession = [[AVCaptureSession alloc] init];
    }
    return self;
}

- (void)addVideoPreviewLayer
{
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
}

- (void)addStillImageOutput
{
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    self.stillImageOutput.outputSettings = outputSettings;
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
//    [[self captureSession] addOutput:[self stillImageOutput]];
    [self.captureSession addOutput:self.stillImageOutput];
}

- (void)removeStillImageOutput
{
    if ([self.captureSession.outputs containsObject:self.stillImageOutput]) {
        [self.captureSession removeOutput:self.stillImageOutput];
    }
}

- (void)captureTakePhoto
{
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
//        CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
//        if (exifAttachments) {
//            NSLog(@"attachements: %@", exifAttachments);
//        } else {
//            NSLog(@"no attachments");
//        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        UIImage *targetImage = fixImageOrientation(image);
        
        float deviceH_WScale = [UIScreen mainScreen].bounds.size.height/[UIScreen mainScreen].bounds.size.width;
        float layerH_WScale = self.previewLayer.frame.size.height/self.previewLayer.frame.size.width;
        
        float resultImageX;
        float resultImageY;
        float resultImageWidth;
        float resultImageHeight;
        
        if (layerH_WScale >= deviceH_WScale) {
            resultImageHeight = targetImage.size.height;
            resultImageWidth = resultImageHeight/layerH_WScale;
            resultImageY = 0;
            resultImageX = (targetImage.size.width - resultImageWidth)/2;
        } else {
            resultImageWidth = targetImage.size.width;
            resultImageHeight =resultImageWidth * layerH_WScale;
            resultImageX = 0;
            resultImageY = (targetImage.size.height - resultImageHeight)/2;
        }
        
        NSLog(@"result :(%f, %f, %f, %f):%f", resultImageX, resultImageY, resultImageWidth, resultImageHeight, resultImageHeight/resultImageWidth);
        UIImage *resultImage = [self getImageFromImage:targetImage withSize:CGRectMake(resultImageX, resultImageY, resultImageWidth, resultImageHeight)];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(captureSessionManagerResultImage:)]) {
            [self.delegate captureSessionManagerResultImage:resultImage];
        }
    }];
}


- (void)addVideoInputFrontCamera:(BOOL)front {
    NSArray *devices = [AVCaptureDevice devices];
    AVCaptureDevice *frontCamera;
    AVCaptureDevice *backCamera;
    
    for (AVCaptureDevice *device in devices) {
        
        NSLog(@"Device name: %@", [device localizedName]);
        
        if ([device hasMediaType:AVMediaTypeVideo]) {
            
            if ([device position] == AVCaptureDevicePositionBack) {
                NSLog(@"Device position : back");
                backCamera = device;
            }
            else {
                NSLog(@"Device position : front");
                frontCamera = device;
            }
        }
    }
    
    NSError *error = nil;
    
    if (front) {
        AVCaptureDeviceInput *frontFacingCameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:frontCamera error:&error];
        if (!error) {
            if ([[self captureSession] canAddInput:frontFacingCameraDeviceInput]) {
                [[self captureSession] addInput:frontFacingCameraDeviceInput];
            } else {
                NSLog(@"Couldn't add front facing video input");
            }
        }
    } else {
        AVCaptureDeviceInput *backFacingCameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
        if (!error) {
            if ([[self captureSession] canAddInput:backFacingCameraDeviceInput]) {
                [[self captureSession] addInput:backFacingCameraDeviceInput];
            } else {
                NSLog(@"Couldn't add back facing video input");
            }
        }
    }
}

- (void)swapFrontAndBackCameras {
    // Assume the session is already running
    
    NSArray *inputs = self.captureSession.inputs;
    for ( AVCaptureDeviceInput *input in inputs ) {
        AVCaptureDevice *device = input.device;
        if ( [device hasMediaType:AVMediaTypeVideo] ) {
            AVCaptureDevicePosition position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront)
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            else
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            // beginConfiguration ensures that pending changes are not applied immediately
            [self.captureSession beginConfiguration];
            
            [self.captureSession removeInput:input];
            [self.captureSession addInput:newInput];
            
            // Changes take effect once the outermost commitConfiguration is invoked.
            [self.captureSession commitConfiguration];
            break;
        }
    } 
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}

// 根据给定得图片，从其指定区域截取一张新得图片
-(UIImage *)getImageFromImage:(UIImage *)originImage withSize:(CGRect)targetImageRect
{
    //定义myImageRect，截图的区域
    CGImageRef imageRef = originImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, targetImageRect);
    CGSize size;
    size.width = targetImageRect.size.width;
    size.height = targetImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, targetImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

// 有时候竖着拍的照片，处理的时候旋转了90度，次方法调整
UIImage *fixImageOrientation (UIImage *oImage)
{
    // No-op if the orientation is already correct
    if (oImage.imageOrientation == UIImageOrientationUp)
        return oImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (oImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, oImage.size.width, oImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, oImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, oImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (oImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, oImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, oImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, oImage.size.width, oImage.size.height,
                                             CGImageGetBitsPerComponent(oImage.CGImage), 0,
                                             CGImageGetColorSpace(oImage.CGImage),
                                             CGImageGetBitmapInfo(oImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (oImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,oImage.size.height,oImage.size.width), oImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,oImage.size.width,oImage.size.height), oImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
