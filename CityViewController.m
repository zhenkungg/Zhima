//
//  CityViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/19.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "CityViewController.h"
#import "AddressPickView.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface CityViewController ()
@property(nonatomic,strong)UILabel *label;
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self _createDisplayLabel];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}-(void)_createDisplayLabel
{
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0,150, kScreenWidth, 50)];
    _label.backgroundColor = [UIColor redColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"点击显示地址选择器";
    [self.view addSubview:_label];
    
    _label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showAddressPickView)];
    [_label addGestureRecognizer:tap];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    
}
- (void)showAddressPickView
{
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        _label.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,town] ;
        _label.font = [UIFont boldSystemFontOfSize:12];
        NSLog(@"%@",_label.text);
    };
}
- (void)saveBtnClick
{
    if (_nextCity) {
        _nextCity(self.label.text);
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
