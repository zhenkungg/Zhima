//
//  EducViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "EducViewController.h"
#import "LMLReportHeadView.h"
@interface EducViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger selectedSection;
    NSString *report_content;
}
@property(nonatomic,strong)UITableView *EduTableview;
@property(nonatomic,strong)NSArray *EduArr;

@property (nonatomic, strong) NSMutableArray *headerArr;
@end

@implementation EducViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    _EduArr = @[@"大专",@"本科",@"研究生",@"博士"];
    [self TableView];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
-(void)TableView {
    _EduTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    
    self.EduTableview.delegate = self;
    self.EduTableview.dataSource  =self;
    self.EduTableview.tableFooterView = [UIView new];
    self.EduTableview.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview: self.EduTableview];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = _EduArr[indexPath.row];
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
    
    view.titleLabel.text = _EduArr[section];
    
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
    report_content = _EduArr[section];
    header.checkImage.hidden = NO;
    NSLog(@"%@",report_content);
    [self.EduTableview  reloadData];
    
}

- (void)saveBtnClick
{
    
    //必须要判断
    if (_nextEdu) {
        _nextEdu(report_content);
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
