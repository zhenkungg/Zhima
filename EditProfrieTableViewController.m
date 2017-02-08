//
//  EditProfrieTableViewController.m
//  lianxi01
//
//  Created by 王勇 on 16/3/27.
//  Copyright © 2016年 Brave. All rights reserved.
//

#import "EditProfrieTableViewController.h"
#import "UIViewController+DismissKeyboard.h"
@interface EditProfrieTableViewController ()
@property (strong, nonatomic)UITextField *textF;

@end

@implementation EditProfrieTableViewController

- (void)viewDidLoad
{
   
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setupForDismissKeyboard];
    _textF = [[UITextField alloc]initWithFrame:CGRectMake(50, 10, 200, 35)];
    self.title = self.cell.detailTextLabel.text;
    self.textF.text = self.cell.textLabel.text;
    self.textF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textF];
    // 添加右边保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)saveBtnClick
{
    // 1.更改上一页cell的detailtextlabel 的text
    self.cell.detailTextLabel.text = self.textF.text;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(saveChangeData)]) {
        // 告诉代理 点击保存按钮
        [self.delegate saveChangeData];
    }

}


@end
