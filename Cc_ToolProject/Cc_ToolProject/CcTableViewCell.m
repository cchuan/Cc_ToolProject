//
//  CcTableViewCell.m
//  Cc_ToolProject
//
//  Created by cchuan on 15/12/18.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import "CcTableViewCell.h"

@implementation CcTableViewCell

- (void)awakeFromNib
{
    self.titleLabel.textColor = [UIColor redColor];
    self.detailLabel.textColor = [UIColor blueColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
