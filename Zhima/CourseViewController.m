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
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface CourseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) CourseTableViewController *courseTable;
/*分段控制器的下标标识符*/
@property (nonatomic,assign) NSInteger *page;

@property (nonatomic,strong) UITableView *myTab;
@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    // Do any additional setup after loading the view.
    _myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, Screen_Width, Screen_Height-100-49) style:UITableViewStylePlain];
    
    _myTab.delegate = self;
    _myTab.dataSource = self;
    
    [self.view addSubview:_myTab];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
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
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    
    navView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:navView];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2 - 40, 20, 80, 30)];
    title.text = @"芝麻授业";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    [self.view addSubview:title];
    
    //分段控制器
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"已授课程",@"待授课程"]];
    segment.frame = CGRectMake(36, 64, Screen_Width-36*2, 30);
    segment.tintColor = [UIColor cyanColor];
    segment.selectedSegmentIndex = 0;
    
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    [segment setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
    
    [self.view addSubview:segment];
    
    [segment addTarget:self action:@selector(segmentChangePage:) forControlEvents:UIControlEventValueChanged];
    
    
}

-(void)segmentChangePage :(UISegmentedControl *)sec;
{
    
    NSInteger index = sec.selectedSegmentIndex;
    if (index == 0) {
        _page = 0;
        [_courseTable.view removeFromSuperview];
    }else{
        _page = 1;
        _courseTable = [[CourseTableViewController alloc]init];
        _courseTable.view.frame = CGRectMake(0, 100, Screen_Width, Screen_Height-100-49);
        [self.view addSubview:_courseTable.view];
        [self addChildViewController:_courseTable];
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
