//
//  SchoolTimeViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/21.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "SchoolTimeViewController.h"
#import "CCPPickerViewTwo.h"
@interface SchoolTimeViewController ()
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)NSString *labelText;
@end

@implementation SchoolTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    _textLabel= [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 35)];
    CCPPickerViewTwo *pickerViewTwo = [[CCPPickerViewTwo alloc] initWithpickerViewWithCenterTitle:@"选择时间" andCancel:@"取消" andSure:@"确定"];
    
    [pickerViewTwo pickerVIewClickCancelBtnBlock:^{
        
        NSLog(@"取消");
        
    } sureBtClcik:^(NSString *leftString, NSString *rightString, NSString *leftAndRightString) {
        
        NSLog(@"%@=======%@=======%@",leftString,rightString,leftAndRightString);
        _textLabel.text =leftAndRightString;
          _labelText =leftAndRightString;
        
        
    }];
    _textLabel.textColor =[UIColor whiteColor];

    _textLabel.text =self.labelText;
    [self.view addSubview:_textLabel];
 

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
-(void)saveBtnClick
{
    
    if (_NextSt) {
        _NextSt(self.labelText);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
