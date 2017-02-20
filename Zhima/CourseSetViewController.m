//
//  CourseSetViewController.m
//  Zhima
//
//  Created by Json on 2017/2/9.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "CourseSetViewController.h"
#import "XHDatePickerView.h"
#import "NSDate+Extension.h"
@interface CourseSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *courseTableView;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (nonatomic)BOOL showList;
@property (nonatomic,strong)NSArray *courseArr;
@end

@implementation CourseSetViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.courseArr = @[@"语文",@"数字",@"英语"];
    [self setTVList];
}

- (IBAction)selectTime:(id)sender {
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate,NSDate *endDate) {
        NSLog(@"\n开始时间： %@，结束时间：%@",startDate,endDate);
        self.startTime.text = [startDate stringWithFormat:@"HH:mm"];
        self.endTime.text = [endDate stringWithFormat:@"HH:mm"];
    }];
    datepicker.datePickerStyle = DateStyleShowHourMinute;
    datepicker.dateType = DateTypeStartDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    datepicker.minLimitDate = [NSDate date:currentTime WithFormat:@"yyyy-MM-dd HH:mm"];
    //datepicker.maxLimitDate = [NSDate date:@"2018-2-28 12:12" WithFormat:@"yyyy-MM-dd HH:mm"];
    [datepicker show];
}

-(void)setTVList{
    self.showList = NO;
    CGRect tvFrame = self.courseTableView.frame;
    self.courseTableView.frame = CGRectMake(tvFrame.origin.x, tvFrame.origin.y, tvFrame.size.width, 0);
    self.courseTableView.delegate = self;
    self.courseTableView.dataSource = self;
    //self.courseTableView.backgroundColor = [UIColor grayColor];
    self.courseTableView.separatorColor = [UIColor lightGrayColor];
    self.courseTableView.hidden = YES;
}
- (IBAction)selectCourse:(id)sender {
    if (self.showList) {
        _showList = NO;
        self.courseTableView.hidden = YES;
        
        CGRect tvFrame = self.courseTableView.frame;
        self.courseTableView.frame = CGRectMake(tvFrame.origin.x, tvFrame.origin.y, tvFrame.size.width, 0);
    }else {
        CGRect tvFrame = self.courseTableView.frame;
        tvFrame.size.height = 75;
        
        [self.view bringSubviewToFront:self.courseTableView];
        self.courseTableView.hidden = NO;
        _showList = YES;
        
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.courseTableView.frame = tvFrame;
        [UIView commitAnimations];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.courseArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.courseLabel.text = self.courseArr[indexPath.row];
    _showList = NO;
    self.courseTableView.hidden = YES;
    
    CGRect tvFrame = self.courseTableView.frame;
    self.courseTableView.frame = CGRectMake(tvFrame.origin.x, tvFrame.origin.y, tvFrame.size.width, 0);
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
