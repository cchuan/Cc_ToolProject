//
//  CcTableViewController.m
//  Cc_ToolProject
//
//  Created by cchuan on 15/12/18.
//  Copyright © 2015年 cchuan. All rights reserved.
//

#import "CcTableViewController.h"
#import "CcTableViewCell.h"

@interface CcTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *ccTableView;

@property (strong, nonatomic) NSMutableArray *cellContentArr;

@end

@implementation CcTableViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.cellContentArr = [[NSMutableArray alloc] initWithObjects:@"测试cell", @"你是谁！", @"Are you OK ?", @"嘿嘿！", @"呵呵", @"我的代码收藏", @"复用", @"轻松拷贝", @"干啥好呢", @"今天周五", @"颠沛流离", @"可不可以", @"这个不好说", @"你开心吗？", @"今夜你会不会来", @"那就这样", nil];
    
    self.ccTableView.backgroundColor = [UIColor clearColor];
    self.ccTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellContentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINib *nib = [UINib nibWithNibName:@"CcTableViewCell" bundle:nil];
    [self.ccTableView registerNib:nib forCellReuseIdentifier:@"CcTableViewCellIdentifier"];
    
    CcTableViewCell *cell = (CcTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CcTableViewCellIdentifier"];
    if (cell == nil) {
        cell= (CcTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"CcTableViewCell" owner:self options:nil]  lastObject];
    }
    
    cell.titleLabel.text = [self.cellContentArr objectAtIndex:indexPath.row];
    cell.detailLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];

    return cell;
}

// 实现删除操作
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return  UITableViewCellEditingStyleDelete;  //返回此值时,Cell会做出响应显示Delete按键,点击Delete后会调用下面的函数,别给传递UITableViewCellEditingStyleDelete参数
//    return  UITableViewCellEditingStyleNone;   //返回此值时,Cell上不会出现Delete按键,即Cell不做任何响应
//    return UITableViewCellEditingStyleInsert;
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"删除";
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.cellContentArr removeObjectAtIndex:indexPath.row];
        [self.ccTableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

// 当实现下面的方法时，上面的方法不会执行
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        DDLogWarn(@"点击删除");
    }];
    
    //此处是iOS8.0以后苹果最新推出的api，UITableViewRowAction，Style是划出的标签颜色等状态的定义，这里也可自行定义
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        DDLogWarn(@"点击编辑");
    }];
    editRowAction.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];//可以定义RowAction的颜色
    return @[deleteRoWAction, editRowAction];//最后返回这俩个RowAction 的数组
}

@end