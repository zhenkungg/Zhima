//
//  PerstontwoViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/16.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "PerstontwoViewController.h"
#import "PersoneTableViewCell.h"
#import "PerThreeViewController.h"
#import "PhaseViewController.h"
#import "SubjectsViewController.h"
#import "ClasssViewController.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface PerstontwoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)PhaseViewController *PHBlock;


@property(nonatomic,strong)SubjectsViewController *SUbBlock;
@property(nonatomic,strong)UITableView *Per1tableview;
@property(nonatomic,strong)NSArray *Perarr;
@property(nonatomic,strong)NSString *PHClass;
@property(nonatomic,strong)NSString *PHSub;




@end

@implementation PerstontwoViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor redColor];
    // Do any additional setup after loading the view.
    [self setUpNav];
    [self  Per1tableView];
}
-(void)Per1tableView
{
    _Per1tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height) style:UITableViewStylePlain];
    _Per1tableview.delegate = self;
    _Per1tableview.dataSource = self ;
    [self.view addSubview:_Per1tableview];
    _Perarr = @[@"教授年级",@"教授科目"];
}
//自定义导航栏
-(void)setUpNav
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,64)];
    
    navView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:navView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2 -80, 20, 160, 30)];
    
    title.text = @"完善个人资料2/5";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    [self.view addSubview:title];
    UIButton *search1 = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-80-10, 20, 65, 40)];
    [search1 setTitle:@"下一步" forState:UIControlStateNormal];
    
    UIButton *search = [[UIButton alloc]initWithFrame:CGRectMake(30, 20, 40, 40)];
    
    [search setImage:[UIImage imageNamed:@"mazoo-logo"] forState:UIControlStateNormal];
    [ search1 addTarget:self action:@selector(searCh1) forControlEvents:UIControlEventTouchUpInside ];
    [ search addTarget:self action:@selector(searCh) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:search1];
    [self.view addSubview:search];
    
    
    
    
}
-(void)searCh1 {
    PerThreeViewController *pertwoVC= [[PerThreeViewController alloc]init];
    [self.navigationController pushViewController:pertwoVC animated:YES];
    
}
-(void) searCh {
    
    [self.navigationController  popViewControllerAnimated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if (section == 0) {
    //        return 1;
    //    }
    return _Perarr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strId = @"pCello";
    PersoneTableViewCell *Pcell = [tableView dequeueReusableCellWithIdentifier:strId];
    Pcell =[[[NSBundle mainBundle]loadNibNamed:@"PersoneTableViewCell" owner:nil options:nil]lastObject];
    Pcell.textLabel.text = _Perarr[indexPath.row];
    //    Pcell =[[[NSBundle mainBundle]loadNibNamed:@"PerTableViewCell" owner:nil options:nil]lastObject];
    if (indexPath.row ==0) {
        Pcell.Peron.text = self.PHClass;
    }else if (indexPath.row==1){
        Pcell.Peron.text =self.PHSub;
    }

    return Pcell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tag = indexPath.row;
    if (tag==0) {
        PhaseViewController *PHVc= [PhaseViewController new];
        PHVc.PhBlock=^(NSString *meStr){
            NSLog(@"%@",meStr);
            self.PHClass = meStr;
            [self viewDidLoad];
        };
         [self.navigationController pushViewController:PHVc animated:YES];
    }
   
    else if (tag==1){
        SubjectsViewController *SUBVC= [SubjectsViewController new];
        SUBVC.nextSub= ^(NSString *meStr){
            self.PHSub = meStr;
          
            [self viewDidLoad];
        };
    
        [self.navigationController pushViewController:SUBVC animated:YES];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"请填写教学资料";
}
@end
