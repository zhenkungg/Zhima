//
//  ViewController.m
//  Zhima
//
//  Created by 古振坤 on 2017/1/11.
//  Copyright © 2017年 zkgg. All rights reserved.
//
#import "ViewController.h"
#import "LoginController.h"
#import "RegisrViewController.h"

#define  LR_Width  [UIScreen mainScreen].bounds.size.width
#define  LR_Height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
@property(nonatomic,strong)UIButton *restbutt;
@property(nonatomic,strong)UIButton *logibutt;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UIImageView *footImage;
@property(nonatomic,strong)UILabel *footLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self redeview];
}

-(void)redeview{
    //
    self.restbutt = [[UIButton alloc]initWithFrame:CGRectMake(LR_Width/4, LR_Height/2-40, LR_Width/2, 35)];
    [self.restbutt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.restbutt setTitle:@"免费注册" forState:UIControlStateNormal];
    [self.restbutt addTarget:self action:@selector(restbutts) forControlEvents:UIControlEventTouchUpInside];
    //
    self.logibutt = [[UIButton alloc ]initWithFrame:CGRectMake(LR_Width/4, LR_Height/2, LR_Width/2, 35)];
    self.logibutt.backgroundColor = [UIColor whiteColor];
    [self.logibutt setTitle:@"马上登陆" forState:UIControlStateNormal];
    [self.logibutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.logibutt addTarget:self action:@selector(logibuts) forControlEvents:UIControlEventTouchUpInside];
    //
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(LR_Width/2-40, 100, 80, 80)];
    self.headImage.image = [UIImage imageNamed:@"mazoo-logo.png"];
    //
    self.footImage = [[UIImageView alloc]initWithFrame:CGRectMake(LR_Width/2-60, LR_Height-60, 35, 35)];
    self.footImage.image = [UIImage imageNamed:@"mazoo-logo.png"];
    //
    self.footLab = [[UILabel alloc]initWithFrame:CGRectMake(LR_Width/2, LR_Height-60, 100, 35)];
    self.footLab.text = @"芝麻学堂";
    
    [self.view addSubview:self.footLab];
    [self.view addSubview:self.footImage];
    [self.view addSubview:self.headImage];
    [self.view addSubview:self.restbutt];
    [self.view addSubview:self.logibutt];
}
-(void)logibuts{
    LoginController *loginVC = [[LoginController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)restbutts{
    RegisrViewController *regitstVC = [[RegisrViewController alloc]init];
    [self.navigationController pushViewController:regitstVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
