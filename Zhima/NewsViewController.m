//
//  NewsViewController.m
//  Zhima
//
//  Created by 古振坤 on 2017/1/11.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *newstableV;

@property(strong,nonatomic)NSMutableArray *dataArray;

@end

@implementation NewsViewController
#pragma mark  数据源懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray ==nil) {
        _dataArray = [NSMutableArray alloc];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  }

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strID = @"NewsCell";
    NewsTableViewCell *newscell = [tableView dequeueReusableCellWithIdentifier:strID];
//    UITableViewCell *newscell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (newscell == nil) {
        newscell = [[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:nil options:nil]lastObject];
    }
    newscell.selectionStyle = UITableViewCellSelectionStyleNone;
//  NewsModel  *model = self.dataArray[indexPath.section];
   
    
    return newscell ;
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
