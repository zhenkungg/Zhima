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
    //_tableView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+64, CGRectGetMaxX(self.view.frame), CGRectGetMaxY(self.view.frame));
    _tableView.frame = self.view.frame;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil]lastObject];
    _tableView.tableHeaderView.frame = CGRectMake(CGRectGetMinX(_tableView.frame), CGRectGetMinY(_tableView.frame), CGRectGetMaxX(_tableView.frame), 200);
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    
    _titles = @[@"个人资料",@"课程设置",@"我的好友",@"我的订单",@"我的收入",@"设置"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 4;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    if (indexPath.section == 0) {
        cell.textLabel.text = _titles[0];
    }else if(indexPath.section == 2){
        cell.textLabel.text = _titles[5];
    }else
    cell.textLabel.text = _titles[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:@"doc"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
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
