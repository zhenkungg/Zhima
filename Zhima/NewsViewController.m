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
#import "NewsConversationListViewController.h"
#import "AppDelegate.h"
//#import "ChatDemoHelper.h"
#import "ChatUIHelper.h"
#import "PersonalViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
//@property (weak, nonatomic) IBOutlet UITableView *newstableV;

@property(strong,nonatomic)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

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

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (IBAction)registeredClick:(id)sender {
    NSString *url = @"http://118.89.45.205/users/reg";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    NSDictionary *parameters = @{
                                 @"username":self.accountTF.text,
                                 @"password":self.passwordTF.text,
                                 @"usertype":@"1"
                                 };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc ]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonString);
    
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSLog(@"%@",formData);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功：%@",responseObject);
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"1111111%@",str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@",error);
    }];
 
}


- (IBAction)loginClick:(id)sender {
    NSString *url = @"http://118.89.45.205/users/login";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    NSDictionary *parameters = @{
                                 @"username":self.accountTF.text,
                                 @"password":self.passwordTF.text,
                                 @"usertype":@"1"
                                 };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc ]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonString);
    
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSLog(@"%@",formData);
        //        NSString *str = [[NSString alloc]initWithData:formData encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",str);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功：%@",responseObject);
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        
        if(self.accountTF.text && self.accountTF.text){
            EMError *error = [[EMClient sharedClient] loginWithUsername:self.accountTF.text password:self.passwordTF.text];
            
            if (error==nil) {
                NSLog(@"登录成功");
                //切换聊天列表为跟控制器
                NewsConversationListViewController  *listVC = [[NewsConversationListViewController alloc] init];
                listVC.title = @"消息列表";
                
                [ChatUIHelper shareHelper].mainVC = listVC;
                
                
                //[AppDelegate getAppDelegate].window.rootViewController = [[UINavigationController alloc] initWithRootViewController:listVC];
                [self.navigationController pushViewController:listVC animated:YES];
                
            }else{
                NSLog(@"登录失败 :%@",error);
            }
        }
        
        
        
        //[AppDelegate getAppDelegate].window.rootViewController = [[UINavigationController alloc] initWithRootViewController:listVC];
                
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@",error);
    }];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 20;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 120;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *strID = @"NewsCell";
//    NewsTableViewCell *newscell = [tableView dequeueReusableCellWithIdentifier:strID];
//
//    if (newscell == nil) {
//        newscell = [[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:nil options:nil]lastObject];
//    }
//    newscell.selectionStyle = UITableViewCellSelectionStyleNone;
//   
//    
//    return newscell ;
//}
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
