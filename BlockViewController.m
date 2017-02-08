


//
//  BlockViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/17.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()
@property (strong, nonatomic)UITextField *textF;
@end

@implementation BlockViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
  
    _textF = [[UITextField alloc]initWithFrame:CGRectMake(50, 70, 200, 35)];
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
//    self.cell.detailTextLabel.text = self.textF.text;
//    
//    [self.navigationController popViewControllerAnimated:YES];
//    
//    if ([self.delegate respondsToSelector:@selector(saveChangeData)]) {
//        // 告诉代理 点击保存按钮
//        [self.delegate saveChangeData];
//    }
//
    //必须要判断
    if (_nextVCBlock) {
        _nextVCBlock(self.textF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
