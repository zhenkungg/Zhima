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
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
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
    self.view.backgroundColor = [UIColor lightGrayColor];
   _newstableV.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_newstableV registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"NewsCell"];
//    UINib *nib = [UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
//    [_newstableV registerNib:nib forCellReuseIdentifier:@"NewsCell"];
//    
    
//    NewsModel *newsmodel = [[NewsModel alloc]init];
    
    [self.view addSubview:self.newstableV];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strID = @"NewsCell";
//    NewsTableViewCell *newscell = [tableView dequeueReusableCellWithIdentifier:strID];
    UITableViewCell *newscell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (newscell == nil) {
        newscell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    newscell.selectionStyle = UITableViewCellSelectionStyleNone;
//  NewsModel  *model = self.dataArray[indexPath.section];
   newscell.textLabel.text = @"lll";
    
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
