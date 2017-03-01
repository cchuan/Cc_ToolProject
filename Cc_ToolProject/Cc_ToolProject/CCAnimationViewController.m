//
//  CCAnimationViewController.m
//  Cc_ToolProject
//
//  Created by cchuan on 2016/11/28.
//  Copyright © 2016年 cchuan. All rights reserved.
//

#import "CCAnimationViewController.h"

@interface CCAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *targetAnimationView;

@end

@implementation CCAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAnimation:(id)sender
{
/*
    // 3秒内向下移动250并慢慢影藏
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    [self.targetAnimationView setAlpha:0.0];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    CGPoint point = self.targetAnimationView.center;
    point.y += 250;
    [self.targetAnimationView setCenter:point];
    [UIView commitAnimations];
 */
    
    /*
    [UIView animateWithDuration:1.0 // 动画时长
                     animations:^{
                         // code...
                         [self.targetAnimationView setAlpha:0.0];
                         
                         CGPoint point = self.targetAnimationView.center;
                         point.y += 250;
                         [self.targetAnimationView setCenter:point];
                     }
                     completion:^(BOOL finished) {
                         // 动画完成后执行
                         // code...
                     }];
     */
    
  
    [UIView animateWithDuration:5.0 // 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:0.2 // 类似弹簧振动效果 0~1
          initialSpringVelocity:2.0 // 初始速度
                        options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                     animations:^{
                         // code...
                         [self.targetAnimationView setAlpha:0.2];
                         
                         CGPoint point = self.targetAnimationView.center;
                         point.y += 250;
                         [self.targetAnimationView setCenter:point];
                     } completion:^(BOOL finished) {
                         // 动画完成后执行
                         // code...
                         [self.targetAnimationView setAlpha:1];
                     }];
    
    
    /*
    void (^keyFrameBlock)() = ^(){
        // 创建颜色数组
        NSArray *arrayColors = @[[UIColor orangeColor],
                                 [UIColor yellowColor],
                                 [UIColor greenColor],
                                 [UIColor blueColor],
                                 [UIColor purpleColor],
                                 [UIColor redColor]];
        NSUInteger colorCount = [arrayColors count];
        // 循环添加关键帧
        for (NSUInteger i = 0; i < colorCount; i++) {
            [UIView addKeyframeWithRelativeStartTime:i / (CGFloat)colorCount
                                    relativeDuration:1 / (CGFloat)colorCount
                                          animations:^{
                                              [self.targetAnimationView setBackgroundColor:arrayColors[i]];
                                          }];
        }
    };
    [UIView animateKeyframesWithDuration:2.0
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:keyFrameBlock
                              completion:^(BOOL finished) {
                                  // 动画完成后执行
                                  // code...
                              }];
     */
}


@end
