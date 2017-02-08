//
//  SubjectsViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "SubjectsViewController.h"
#import "LMLReportHeadView.h"
@interface SubjectsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger selectedSection;
    NSString *report_content;  // 内容
}
@property(nonatomic,strong)UITableView *SUbtable;
@property(nonatomic,strong)NSArray *SUbArr;
@property(nonatomic,strong)NSMutableArray *headerArr;
@end

@implementation SubjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    _SUbArr = @[@"语文",@"数学",@"英语",@"其他"];
    [self TableView];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
-(void)TableView {
    _SUbtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    
    self.SUbtable.delegate = self;
    self.SUbtable.dataSource  =self;
    self.SUbtable.tableFooterView = [UIView new];
    self.SUbtable.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview: self.SUbtable];
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
    cell.textLabel.text = _SUbArr[indexPath.row];
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
    
    view.titleLabel.text = _SUbArr[section];
    
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
    
    //    if (selectedSection == section) {
    //
    //        return;
    //    }else {
    //
    //
    //    }
    
    selectedSection = section;
    
    /*if (Display[section]) {
     
     return;
     }*/
    
    //    NSIndexSet * set = [NSIndexSet indexSetWithIndex:tap.view.tag];
    //    for (int i = 0; i < 9; i ++) {
    //
    //        LMLReportHeadView *header = _headerArr[i];
    //        header.checkImage.hidden = YES;
    //
    //    }
    LMLReportHeadView *header = _headerArr[section];
    report_content = _SUbArr[section];
    header.checkImage.hidden = NO;
    NSLog(@"%@",report_content);
    [self.SUbtable reloadData];
    
}

- (void)saveBtnClick
{
    
    //必须要判断
    if (_nextSub) {
        _nextSub(report_content);
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
