//
//  PersonViewController.m
//  Zhima
//
//  Created by Json on 2017/1/11.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *titles;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+64, CGRectGetMaxX(self.view.frame), CGRectGetMaxY(self.view.frame));
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _titles = @[@"个人资料",@"课程设置",@"我的好友",@"我的订单",@"我的收入"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1;
    }else
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (indexPath.section == 1) {
        cell.textLabel.text = _titles[0];
    }else
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
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
