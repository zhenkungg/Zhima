//
//  SchoolViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "SchoolViewController.h"

@interface SchoolViewController ()

@property(nonatomic,strong)UITextField *TextF;

@end

@implementation SchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor redColor];
    _TextF = [[UITextField alloc]initWithFrame:CGRectMake(20, 70, 200, 35)];
    self.TextF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TextF];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveButClick)];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
-(void)saveButClick
{
    if (_NextSchool) {
        _NextSchool(self.TextF.text);
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
