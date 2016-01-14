//
//  ViewController.m
//  Cc_ToolProject
//
//  Created by cchuan on 15/12/18.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import "ViewController.h"
#import "TakePhoteViewController.h"
#import "CctableViewcontroller.h"
#import "AlertViewController.h"
#import "ScrollViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *shoppingCartButton;

@property (strong, nonatomic) NSMutableArray<CALayer *> *redLayers;


@end

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)actionButtonClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *titleStr = btn.currentTitle;
    
    if ([titleStr isEqualToString:@"takePhotoVC"]) {
        TakePhoteViewController *takePhotoVC = [[TakePhoteViewController alloc] init];
        [self.navigationController pushViewController:takePhotoVC animated:YES];
    } else if ([titleStr isEqualToString:@"tableViewVC"]) {
        CcTableViewController *ccTableViewVC = [[CcTableViewController alloc] init];
        [self.navigationController pushViewController:ccTableViewVC animated:YES];
    } else if ([titleStr isEqualToString:@"alertView"]) {
        AlertViewController *alertVC = [[AlertViewController alloc] init];
        [self.navigationController pushViewController:alertVC animated:YES];
    } else if ([titleStr isEqualToString:@"scrollView"]) {
        ScrollViewController *scrollViewVC = [[ScrollViewController alloc] init];
        [self.navigationController pushViewController:scrollViewVC animated:YES];
    }
}

- (IBAction)addButtonClick:(id)sender
{
    /*
     // 在tableView中，起点是cell上的点，
     // position在cell中取 CGPoint btnPoint = [self convertPoint:self.plusBtn.center toView:self.superview]; // self.plusBtn是cell上点击的按钮
     
     // 下面内容在cellFor方法中
     CGPoint startPoint = [self.view convertPoint:position fromView:self.tableView];
     CGPoint endPoint = [self.view convertPoint:self.shippingCartView.center fromView:self.bottomView]; // self.bottomView是购物车所在view
     */
    
    CGPoint startPoint = self.addButton.center;
    CGPoint endPoint = self.shoppingCartButton.center;
    [self initCHLayerFromPoint:startPoint toPoint:endPoint];
}

- (NSMutableArray<CALayer *> *)redLayers {
    if (!_redLayers) {
        _redLayers = [NSMutableArray array];
    }
    return _redLayers;
}

// 点击添加东西到购物车时，有个加入购物车的动画
- (void)initCHLayerFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint {
    
    CALayer *chLayer = [[CALayer alloc] init];
    [self.redLayers addObject:chLayer];
    
    chLayer.frame = CGRectMake(startPoint.x, startPoint.y, 15, 15);
    chLayer.cornerRadius = CGRectGetWidth(chLayer.frame)/2.f;
    chLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:chLayer];
    
    CAKeyframeAnimation *CHAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddQuadCurveToPoint(path, NULL, endPoint.x, startPoint.y, endPoint.x, endPoint.y);
    
    CHAnimation.path = path;
    CHAnimation.removedOnCompletion = NO;
    CHAnimation.fillMode = kCAFillModeBoth;
    CHAnimation.duration = 0.5;
    CHAnimation.delegate = self;
    
    [chLayer addAnimation:CHAnimation forKey:nil];
}

// 动画结束时，移除移动的圆点
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.redLayers[0] removeFromSuperlayer];
    [self.redLayers removeObjectAtIndex:0];
}

@end
