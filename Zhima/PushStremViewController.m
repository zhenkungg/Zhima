//
//  PushStremViewController.m
//  Zhima
//
//  Created by Json on 2017/1/13.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "PushStremViewController.h"
#import "StartViewController.h"

@interface PushStremViewController ()
@property (nonatomic,strong)UIButton *beginLiveButton;
@end

@implementation PushStremViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_zbfx"]];
    //设置开始直播按钮
    [self setUpBeginLiveButton];
    // Do any additional setup after loading the view.
}

-(void)setUpBeginLiveButton{
    _beginLiveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_beginLiveButton];
    [_beginLiveButton setTitle:@"开始直播" forState:UIControlStateNormal];
    [_beginLiveButton addTarget:self action:@selector(playInputClick) forControlEvents:UIControlEventTouchUpInside];
    _beginLiveButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"room_button"]];
    //self.view.translatesAutoresizingMaskIntoConstraints = NO;
    _beginLiveButton.translatesAutoresizingMaskIntoConstraints = NO;
    //创建约束 高 宽
    NSLayoutConstraint *beginLiveButtonHeight = [NSLayoutConstraint constraintWithItem:_beginLiveButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45];
    NSLayoutConstraint *beginLiveButtonWidth = [NSLayoutConstraint constraintWithItem:_beginLiveButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:250];
    [_beginLiveButton addConstraint:beginLiveButtonHeight];
    [_beginLiveButton addConstraint:beginLiveButtonWidth];
    
    //添加y方向的约束
    NSLayoutConstraint *beginLiveButtonY = [NSLayoutConstraint constraintWithItem:_beginLiveButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    //x方向
    NSLayoutConstraint *beginLiveButtonX = [NSLayoutConstraint constraintWithItem:_beginLiveButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:beginLiveButtonX];
    [self.view addConstraint:beginLiveButtonY];
    
}

-(void)playInputClick{
    StartViewController *vc = [[StartViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
