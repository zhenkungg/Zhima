//
//  CourseViewController.m
//  Zhima
//
//  Created by 古振坤 on 2017/1/12.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "CourseViewController.h"
#import "CourseTableViewController.h"
#import "NewsTableViewCell.h"

#import "NHConstants.h"
#import "NSDate+Common.h"
#import "NHCalender.h"
#import "WorkCourseSetViewController.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface CourseViewController ()<UITableViewDelegate,UITableViewDataSource,CalendarDelegate,CalendarDataSource>

@property(nonatomic,strong) CourseTableViewController *courseTable;
/*分段控制器的下标标识符*/
@property (nonatomic,assign) NSInteger *page;

@property (nonatomic,strong) UITableView *myTab;

//日历控件相关属性
@property (nonatomic,strong)UIButton *yearAndMonthBtn;
@property (nonatomic,strong)NHCalender *calendar;
@property (nonatomic,strong)NSCalendar *gregorian;
@property (nonatomic,strong)NSDate *selectDate;
@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    
    [self setSubViews];
    
    _myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+Screen_Width+31-80, Screen_Width, Screen_Height-64-Screen_Width+80-1) style:UITableViewStylePlain];
    
    _myTab.delegate = self;
    _myTab.dataSource = self;
    
    [self.view addSubview:_myTab];
}
//添加子控件
-(void)setSubViews{
    _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [_gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:[NSDate date]];
    NSInteger year = [components year];
    NSInteger month = [components month];
    
    CGFloat btnwidth = Screen_Width/3;
    CGFloat btnHeight = 30;
    CGFloat curY = 64;
    CGRect infoRect = CGRectMake(Screen_Width/3, curY, btnwidth, btnHeight);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = infoRect;
    [btn setTitle:[NSString stringWithFormat:@"%zd年-%zd月",year,month] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _yearAndMonthBtn = btn;
    [self.view addSubview:_yearAndMonthBtn];
    
    infoRect.origin.x = Screen_Width/5;
    infoRect.size.width = Screen_Width/5;
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = infoRect;
    [btn setTitle:@"上月" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(preMonth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    infoRect.origin.x = Screen_Width*3/5;
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = infoRect;
    [btn setTitle:@"下月" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //日历表
    curY += btnHeight;
    infoRect = CGRectMake(0, curY, Screen_Width, Screen_Width-80);
    _calendar = [[NHCalender alloc] initWithFrame:infoRect];
    _calendar.delegate = self;
    _calendar.dataSource = self;
    _calendar.calendarDate = [NSDate date];
    _calendar.currentMonth = [NSDate date];
    _calendar.borderSelectColor = [UIColor blackColor];
    [self.view addSubview:_calendar];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, curY+Screen_Width-80, Screen_Width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
}

- (void)nextMonth{
    [_calendar nextMonth];
}

- (void)preMonth{
    [_calendar previousMonth];
}

- (void)showMonth {
    //NSDate *monthDate = [NSDate dateWithYear:2015 Month:5 Day:3 Hour:2 Minute:2 Second:2];
    NSDate *monthDate = [NSDate date];
    [_calendar showMonth:monthDate];
}

#pragma mark - Calendar Delegate

- (BOOL)canChangeToDate:(NSDate *)date {
    return true;
}

- (UIColor *)titleColorForDate:(NSDate *)date{
    UIColor *color;
    if (![date sameMonthWithDate:_calendar.currentMonth]) {
        color = [UIColor lightGrayColor];
    }else{
        if ([date sameDayWithDate:_calendar.calendarDate]) {
            color = RGBCOLOR(237, 0, 0);
        } else {
            color = RGBCOLOR(0, 0, 0);
        }
    }
    
    return color;
}
- (UIColor *)borderColorForDate:(NSDate *)date{
    UIColor *color = [UIColor whiteColor];
    if ([date sameMonthWithDate:_calendar.currentMonth]) {
        if ([date sameDayWithDate:_calendar.calendarDate]) {
            color = RGBCOLOR(237, 0, 0);
        }
    }
    
    return color;
}
- (UIColor *)backgroundColorForDate:(NSDate *)date{
    UIColor *color = [UIColor whiteColor];
    //如果当下有事件则可根据日期自定义颜色
    if ([self hasEvent:date]) {
        color = [UIColor greenColor];
    }
    return color;
}

- (void)calendarChangedMonth{
    NSInteger month = [_calendar.currentMonth month];
    
    NSInteger year = [_calendar.currentMonth year];
    [_yearAndMonthBtn setTitle:[NSString stringWithFormat:@"%zd年-%zd月",year,month] forState:UIControlStateNormal];
}

- (void)calendarDidSelectedDate:(NSDate *)selectedDate{
    NSDateFormatter *format = [NSDate defaultDateFormatterWithFormatYYYYMMdd];
    NSString *info= [format stringFromDate:selectedDate];
    NSLog(@"did select date:%@",info);
    self.selectDate = selectedDate;
    [self backgroundColorForDate:selectedDate];
}

- (BOOL)hasEvent:(NSDate *)date {
    if ([date isEqual:self.selectDate]) {
        return true;
    }
    return false;
}

#pragma mark TableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strID = @"NewsCell";
    NewsTableViewCell *newscell = [tableView dequeueReusableCellWithIdentifier:strID];
    
    if (newscell == nil) {
        newscell = [[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:nil options:nil]lastObject];
        newscell.tiemlable.text = @"ss";
    }
    newscell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return newscell ;
}



-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

//自定义导航栏
-(void)setUpNav
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    
    navView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:navView];
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2 - 40, 20, 80, 30)];
//    title.text = @"芝麻授业";
//    title.font = [UIFont systemFontOfSize:19];
//    title.textColor = [UIColor whiteColor];
//    [self.view addSubview:title];
    
    //分段控制器
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"作业辅导",@"直播课"]];
    segment.frame = CGRectMake(100, 30, Screen_Width-100*2, 24);
    segment.tintColor = [UIColor cyanColor];
    segment.selectedSegmentIndex = 0;
    
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    
    [self.view addSubview:segment];
    
    [segment addTarget:self action:@selector(segmentChangePage:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addBtn.frame = CGRectMake(Screen_Width-50, 30, 40, 24);
    [addBtn addTarget:self action:@selector(addCourse) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

-(void)addCourse{
    WorkCourseSetViewController *vc = [[WorkCourseSetViewController alloc]initWithNibName:@"WorkCourseSetViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)segmentChangePage :(UISegmentedControl *)sec;
{
    
    NSInteger index = sec.selectedSegmentIndex;
    if (index == 0) {
        _page = 0;
        [_courseTable.view removeFromSuperview];
    }else{
        
    }
    
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
