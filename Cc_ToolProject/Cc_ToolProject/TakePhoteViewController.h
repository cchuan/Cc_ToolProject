//
//  TakePhoteViewController.h
//  CameDemo
//
//  Created by cchuan on 15/12/8.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TakePhotoResultDelegate <NSObject>

- (void)resultImage:(UIImage *)image;

@end


@interface TakePhoteViewController : UIViewController

@property (nonatomic, assign) id<TakePhotoResultDelegate>delegate;


@end
