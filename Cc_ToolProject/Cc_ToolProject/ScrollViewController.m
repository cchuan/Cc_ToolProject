//
//  ScrollViewController.m
//  Cc_ToolProject
//
//  Created by cchuan on 15/12/28.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (strong, nonatomic) IBOutlet UIPageControl *myPagecontrol;

@end

@implementation ScrollViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float scrollWidth = [UIScreen mainScreen].bounds.size.width - 20;

    self.myScrollview.backgroundColor = [UIColor yellowColor];
    self.myScrollview.contentSize = CGSizeMake(scrollWidth * 4, 140);
    //    self.myScrollview.contentInset = UIEdgeInsetsZero;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.myScrollview.pagingEnabled = YES;
    
    for (int i = 0; i <= 3; i++) {
        UILabel *l = [[UILabel alloc] init];
        l.frame = CGRectMake(80 + scrollWidth*i, 60, 120, 30);
        l.backgroundColor = [UIColor clearColor];
        l.text = [NSString stringWithFormat:@"Page :%d", i + 1];
        [self.myScrollview addSubview:l];
    }
    
    self.myPagecontrol.currentPage = 0;
    self.myPagecontrol.numberOfPages = 4;
    self.myPagecontrol.currentPageIndicatorTintColor = [UIColor redColor];
    self.myPagecontrol.pageIndicatorTintColor = [UIColor lightGrayColor];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView.contentOffset.x < -60) {
//        self.myPagecontrol.currentPage = 3;
//        self.myScrollview.contentOffset = CGPointMake(scrollView.frame.size.width*3, 0);
//    } else if (scrollView.contentOffset.x > scrollView.frame.size.width*3 + 60) {
//        self.myPagecontrol.currentPage = 0;
//        self.myScrollview.contentOffset = CGPointMake(0, 0);
//    } else {
//        NSInteger pageInt = scrollView.contentOffset.x / scrollView.frame.size.width;
//        self.myPagecontrol.currentPage = pageInt;
//    }
    
    NSInteger pageInt = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.myPagecontrol.currentPage = pageInt;
}

@end
