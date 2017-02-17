//
//  PersonalViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/16.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "PersonalViewController.h"
#import "NewsViewController.h"
#import "PerstontwoViewController.h"
#import "PersoneTableViewCell.h"
#import "PerTableViewCell.h"
#import "UserInfo.h"
#import "EditProfrieTableViewController.h"
#import "BlockViewController.h"
#import "CityViewController.h"
#import "BlockTextViewController.h"
#import "PerCollectionViewCell.h"
#import "PeraTableViewCell.h"
#import "AddressPickView.h"
#import <AFNetworking.h>
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ChangeDelegate,UITextFieldDelegate>

@property(strong, nonatomic)BlockViewController * BlockVC;
@property(strong,nonatomic)CityViewController *BlockCity;
@property(strong,nonatomic)BlockTextViewController *BlockT;
@property(nonatomic,strong)UITableView *PonetableView;
@property(nonatomic,strong)NSArray *PonedataArr;
@property(nonatomic,strong)UIImageView *perImage;
@property(nonatomic,strong)UILabel *gende;
@property(nonatomic,strong)NSMutableArray *perArr;
@property(nonatomic ,strong)NSString *perName;
@property(nonatomic,strong)NSString *perGender;
@property(nonatomic,strong)NSString *perAddress;
@property (nonatomic,strong)NSString *perPlace;
@property(nonatomic,strong)NSString *PerPhone;
@property(nonatomic,strong)NSFileManager *fileManager;

//
@property(nonatomic,strong)UITextField *teF;

@end

@implementation PersonalViewController
-(NSArray *)PonedataArr
{
    if (_PonedataArr == nil) {
        _PonedataArr = [[NSArray alloc ]init];
    }
    return _PonedataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    _PonetableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _PonetableView.dataSource= self;
    _PonetableView.delegate = self ;
    //cell 分割线设置         
    _PonetableView.separatorStyle = NO;
    self.view.backgroundColor =[UIColor whiteColor];
   
    _perImage = [[UIImageView alloc]init];
    _perImage.frame =CGRectMake(kScreenWidth-85, 45, 80, 80);
    _perImage.image = [UIImage imageNamed:@"mazoo-logo"];
    _perImage.layer.cornerRadius = 40;
    _perImage.layer.masksToBounds =YES;
    self.perImage.image = [UIImage imageWithData:[UserInfo sharedUserInfo].imageData];
    _gende = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-120, 35)];
    _gende.backgroundColor= [UIColor redColor];
    [_PonetableView addSubview:_gende];
    [_PonetableView addSubview:_perImage];
    _PonedataArr = @[@"个人真实头像",@"姓名",@"性别",@"所在地区",@"个人介绍"];
    [self.view addSubview:_PonetableView];
     self.view.translatesAutoresizingMaskIntoConstraints= NO;
    

}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden =YES;
}
-(void)cellseton
{
}
//自定义导航栏
-(void)setUpNav
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,64)];
    
    navView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:navView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 -80, 20, 160, 30)];
    
    title.text = @"完善个人资料1/5";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    [self.view addSubview:title];
     UIButton *search1 = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-80-10, 20, 65, 40)];
    [search1 setTitle:@"下一步" forState:UIControlStateNormal];
    
        UIButton *search = [[UIButton alloc]initWithFrame:CGRectMake(30, 20, 40, 40)];
    
        [search setImage:[UIImage imageNamed:@"mazoo-logo"] forState:UIControlStateNormal];
    [ search1 addTarget:self action:@selector(searCh1) forControlEvents:UIControlEventTouchUpInside ];
    [ search addTarget:self action:@selector(searCh) forControlEvents:UIControlEventTouchUpInside ];
        [self.view addSubview:search1];
        [self.view addSubview:search];
   
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
   
   else if  (section == 1) {
        return 3;
   }else{
       return 2;
   }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strId = @"pCello";
    if (indexPath.section == 0) {
        PerCollectionViewCell *Pcell= [tableView dequeueReusableCellWithIdentifier:strId];
        Pcell =[[[NSBundle mainBundle]loadNibNamed:@"PerCollectionViewCell" owner:nil options:nil]lastObject];
        if (indexPath.row ==0) {
            Pcell.textLabel.text = @"个人真实头像";
        }
    
  return Pcell;
    }
   else if (indexPath.section == 1) {
        PersoneTableViewCell *Pcell = [tableView dequeueReusableCellWithIdentifier:strId];
     Pcell =[[[NSBundle mainBundle]loadNibNamed:@"PersoneTableViewCell" owner:nil options:nil]lastObject];
        if (indexPath.row ==0) {
            Pcell.name.text = @"姓名";
            Pcell.Peron.text = self.perName;
            [Pcell setBlock:^(NSString *TextName) {
                self.perName = TextName;
            }];
        }else if (indexPath.row == 1) {
            Pcell.name.text = @"性别";
            Pcell.Peron.text = self.perGender;
            [Pcell setBlock:^(NSString *TextName) {
                self.perGender = TextName;
            }];
            NSLog(@"%@",Pcell.Peron.text);
        }else{
            Pcell.name.text = @"电话号码";
            Pcell.Peron.text = self.PerPhone;
            [Pcell setBlock:^(NSString *TextName) {
                self.PerPhone = TextName;
                [self valiMobile:self.PerPhone];
            }];
        }
        return Pcell;
        }
     else  {
        PeraTableViewCell *Pcell = [tableView dequeueReusableCellWithIdentifier:strId];
        Pcell =[[[NSBundle mainBundle]loadNibNamed:@"PeraTableViewCell" owner:nil options:nil]lastObject];
        if (indexPath.row ==0) {
            Pcell.Pera.text = @"地址";
            Pcell.Perl.text = self.perAddress;
        }else if (indexPath.row == 1) {
            Pcell.Pera.text = @"自我介绍";
            Pcell.Perl.text = self.perPlace;
        }
       
   return Pcell;
    }
}
-(NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length != 11)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号长度只能是11位" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
       
        
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的电话号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        
        }
    }
    return nil;
}
//Cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tag       = indexPath.row;
    if (indexPath.section == 0) {
        if (tag == 0) {
            UIActionSheet *action    = [[UIActionSheet alloc] initWithTitle:@"选择相片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"本地相册", nil];
            [action showInView:self.view];
        }

    }
   else if (indexPath.section == 1) {
       if(tag  == 0)
       {
           
//           BlockViewController * BlockVC = [BlockViewController new];
//           
//           //当且仅当nextVCBlock在A中被调用时，block内部才会被执行,此作用一是初始化nextVCBlock，而是获取值
//           BlockVC.nextVCBlock = ^(NSString * meStr){
//               NSLog(@"我是block传来的值 == %@",meStr);
//               self.perStr = meStr;
//               NSLog(@"%@",self.perStr);
//               [self viewDidLoad];
//               
//           };
//              [self.navigationController pushViewController:BlockVC animated:YES];
           
//           self.perName = self.teF.text;
//           [self viewDidLoad];
           
       }
       else if (tag == 1) {
//           BlockViewController * BlockVC = [BlockViewController new];
//           
//           //当且仅当nextVCBlock在A中被调用时，block内部才会被执行,此作用一是初始化nextVCBlock，而是获取值
//           BlockVC.nextVCBlock = ^(NSString * meStr){
//               NSLog(@"我是block传来的值 == %@",meStr);
//               self.per1Str = meStr;
//               
//               NSLog(@"%@",self.perStr);
//               
//               [self viewDidLoad];
//               
//           };
           
           //        [self.navigationController pushViewController:BlockVC animated:YES];
           
//           self.perGender = @"ddd";
//           [self viewDidLoad];
           
       }

   }else{
       if (tag ==0)
       {
           
           AddressPickView *addressPickView = [AddressPickView shareInstance];
           [self.view addSubview:addressPickView];
           addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
               self.perAddress= [NSString stringWithFormat:@"%@%@%@",province,city,town] ;
               [self viewDidLoad];
               
           };
           
       } else if (tag ==1)
       {
           BlockTextViewController * BlockVC = [BlockTextViewController new];
           
           //当且仅当nextVCBlock在A中被调用时，block内部才会被执行,此作用一是初始化nextVCBlock，而是获取值
           BlockVC.NextBt= ^(NSString * meStr){
               NSLog(@"我是block传来的值 == %@",meStr);
               self.perPlace =@"已填写";
               [self viewDidLoad];
               
           };
           
           [self.navigationController pushViewController:BlockVC animated:YES];
       }

   }
   
}

#pragma mark - UIActionSheet代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 2){
        return ;
    }
    
    //创建图片选择器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //设置代理
    imagePicker.delegate = self;
    //设置图片选择属性
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0) { //照相
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){//真机打开
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
        }else{// 模拟器打开
            
            NSLog(@"模拟器打开");
            return;
            
        }
        
    }else{//相册
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    // 进去选择器
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.fileManager = [NSFileManager defaultManager];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image = [[UIImage alloc] init];
    if ([mediaType isEqualToString:@"public.image"]){
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [_perImage setImage:image];
        //        [_changeBtn setImage:image forState:UIControlStateNormal];
        NSData *data;
        
        if (UIImagePNGRepresentation(image) == nil) {
            
            data = UIImageJPEGRepresentation(image, 1);
            
        } else {
            
            data = UIImageJPEGRepresentation(image, 0.001); //压缩图片，方便上传
        }
        
        //       //获取文件路径
        
        NSString *imageString = [data base64EncodedStringWithOptions:0];
//        转成base64字符串imageString，再传给给后台，在传参中需要添加图片的类型（@“png”或@“jpg”等）
        [self.fileManager createFileAtPath:[imageString stringByAppendingString:@"/image.png"] contents:data attributes:nil];  //将图片保存为PNG格式
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 35;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"请填写基本资料";
}

- (void)saveChangeData {
    
    [UserInfo sharedUserInfo].gender = self.gende.text;
//    [UserInfo sharedUserInfo].yourName = self.youName.text;
    [UserInfo sharedUserInfo].imageData = UIImagePNGRepresentation(self.perImage.image);
    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
    
    NSLog(@"保存");
   
}
-(void)searCh1 {
    [_PonetableView reloadData];
    NSLog(@"%@,%@,%@",self.perGender,self.perName,self.PerPhone);
    [self Updata];
   PerstontwoViewController *pertwoVC= [[PerstontwoViewController alloc]init];
    [self.navigationController pushViewController:pertwoVC animated:YES];
}
-(void)Updata{
    NSString *url = @"http://118.89.45.205/users/updateTeacherDetail";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    NSDictionary *parameters = @{@"username":@"2",
                                 @"token":@"ea2ded9df2a5b28e97b8ccc5bbe09c1b",
                                 @"identname":@"ff",
                                 @"phone":@"13450747644",
                                 @"gender":@"男",
                                 @"address":@"ssss",
                                 @"resume":@"222"};
    //    NSDictionary *parameters = @{@"username":@"25",
    //                                 @"identname":@"gu",
    //                                @"token":@"ef2223b00ed848ccb1645c9daaa0154b",
    //                                 @"resume":@"ddd"};
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/guzhenkun/Desktop/image/mazoo-logo.png"] name:@"avatar" fileName:@"2.png" mimeType:@"image/png" error:nil];
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
-(void)searCh {
    [self.navigationController  popViewControllerAnimated:YES];
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
