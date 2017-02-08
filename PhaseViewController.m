//
//  PhaseViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "PhaseViewController.h"
#import "LMLReportHeadView.h"
@interface PhaseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger selectedSection;
    NSString *report_content;  // 内容
}
@property(nonatomic,strong)UITableView *PhTableView;
@property(nonatomic,strong)NSArray *PhArr;

@property (nonatomic, strong) NSMutableArray *headerArr;

@end

@implementation PhaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    _PhArr = @[@"小学1年级",@"小学2年级",@"小学3年级",@"小学4年级",@"小学5年级",@"小学6年级"];
    [self TableView];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
-(void)TableView {
    _PhTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    
    self.PhTableView.delegate = self;
    self.PhTableView.dataSource  =self;
    self.PhTableView.tableFooterView = [UIView new];
    self.PhTableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview: self.PhTableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = _PhArr[indexPath.row];
    LMLReportHeadView *view = _headerArr[selectedSection];
    if (indexPath.row == selectedSection) {
        
        view.checkImage.hidden = NO;
    }else {
        view.checkImage.hidden = YES;
    }
    
    return cell;
    
}
// 这个是header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    LMLReportHeadView *view = [[NSBundle mainBundle] loadNibNamed:@"LMLReportHeadView" owner:self options:nil].firstObject;//[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    view.userInteractionEnabled = YES;
    
    view.tag = section;
    
    view.titleLabel.text = _PhArr[section];
    
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(display1:)]];
    
    if (section == selectedSection) {
        
        view.checkImage.hidden = NO;
    }
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

#pragma mark - private methods

- (void)display1:(UITapGestureRecognizer *)tap
{
    NSInteger section = tap.view.tag;
    selectedSection = section;
     LMLReportHeadView *header = _headerArr[section];
    report_content = _PhArr[section];
    header.checkImage.hidden = NO;
    NSLog(@"%@",report_content);
    [self.PhTableView reloadData];
    
}

- (void)saveBtnClick
{
    //必须要判断
    if (_PhBlock) {
        _PhBlock(report_content);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
