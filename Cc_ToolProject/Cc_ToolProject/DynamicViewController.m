//
//  DynamicViewController.m
//  MyTestDemo
//
//  Created by cchuan on 15/11/16.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import "DynamicViewController.h"
#import "NewtonsCradleView.h"

@interface DynamicViewController ()
{
    NewtonsCradleView *cradleView;
    
    UIView *testView;
    
    UIDynamicAnimator *_animator;
    UIPushBehavior *_userDragBehavior;
}

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(198, 198, 4, 4)];
    pointView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:pointView];
    
    testView = [[UIView alloc] initWithFrame:CGRectMake(20.0, 400.0, 50.0, 50.0)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleBallPan:)];
    [testView addGestureRecognizer:panGesture];
    
//    [testView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:Nil];
    
    UIDynamicBehavior *behavior = [[UIDynamicBehavior alloc] init];
    
//    [self applyAttachBehaviorForBalls:behavior];
    
    [behavior addChildBehavior:[self createGravityBehaviorForObjects:@[testView]]];
    [behavior addChildBehavior:[self createCollisionBehaviorForObjects:@[testView]]];
    [behavior addChildBehavior:[self createAttach]];
    [behavior addChildBehavior:[self createItemBehavior]];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    [_animator addBehavior:behavior];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //    Observer方法，当ball的center属性发生变化时，刷新整个view
    [self updateLine];
}

- (void)updateLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
//    for(id<UIDynamicItem> ballBearing in _balls){
    CGPoint anchor = CGPointMake(200.0, 200.0) ;//[[_anchors objectAtIndex:[_balls indexOfObject:ballBearing]] center];
        CGPoint ballCenter = [testView center];
        CGContextMoveToPoint(context, anchor.x, anchor.y);
        CGContextAddLineToPoint(context, ballCenter.x, ballCenter.y);
        CGContextSetLineWidth(context, 1.0f);
        [[UIColor blackColor] setStroke];
        CGContextDrawPath(context, kCGPathFillStroke);
//    }
//    [self setBackgroundColor:[UIColor whiteColor]];
}

- (UIDynamicBehavior *)createGravityBehaviorForObjects:(NSArray *)objects
{
    //    为所有的球添加一个重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:objects];
    gravity.magnitude = 10;
    return gravity;
}

- (UIDynamicBehavior *)createCollisionBehaviorForObjects:(NSArray *)objects
{
    //    为所有的球添加一个碰撞行为
    return [[UICollisionBehavior alloc] initWithItems:objects];
}

// 吸附行为
- (UIDynamicBehavior *)createAttach
{
    UIAttachmentBehavior *attach = [[UIAttachmentBehavior alloc] initWithItem:testView attachedToAnchor:CGPointMake(200.0, 200.0)];
    return  attach;
}

- (UIDynamicItemBehavior *)createItemBehavior
{
    //    为所有的球的动力行为做一个公有配置，像空气阻力，摩擦力，弹性密度等
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[testView]];
    
    itemBehavior.elasticity = 1.0;
    itemBehavior.allowsRotation = NO;
    itemBehavior.resistance = 1.f;
    return itemBehavior;
}

-(void)handleBallPan:(UIPanGestureRecognizer *)recoginizer
{
    //用户开始拖动时创建一个新的UIPushBehavior,并添加到animator中
    if(recoginizer.state == UIGestureRecognizerStateBegan){
        if (_userDragBehavior) {
            [_animator removeBehavior:_userDragBehavior];
        }
        _userDragBehavior = [[UIPushBehavior alloc] initWithItems:@[recoginizer.view] mode:UIPushBehaviorModeContinuous];
        [_animator addBehavior:_userDragBehavior];
    }
    
    //用户完成拖动时，从animator移除PushBehavior
    _userDragBehavior.pushDirection = CGVectorMake([recoginizer translationInView:self.view].x/10.f, 0);
    if (recoginizer.state == UIGestureRecognizerStateEnded) {
        
        [_animator removeBehavior:_userDragBehavior];
        _userDragBehavior = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
