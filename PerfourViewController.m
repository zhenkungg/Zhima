


//
//  PerfourViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/17.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "PerfourViewController.h"
#import "PersoneTableViewCell.h"
#import "PeraTableViewCell.h"
#import "PerTableViewCell.h"
#import "EducViewController.h"
#import "SchoolViewController.h"
#import "SchoolTimeViewController.h"
#import "CCPPickerViewTwo.h"
#import "PerFiveViewController.h"
#import <AFNetworking.h>
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface PerfourViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)EducViewController *EduBlock;
@property(nonatomic,strong)SchoolViewController *SchoolBlock;
@property(nonatomic,strong)SchoolTimeViewController *SchooltBlock;
@property(nonatomic,strong)UITableView *PerfTableView;
@property(nonatomic,strong)NSArray *PertfArr;
@property(nonatomic,strong)NSData *image4;
@property(nonatomic,strong)UIImageView *per4Image;
//
@property(nonatomic,strong)NSString *EduStr;
@property(nonatomic,strong)NSString *EduSchool;
@property(nonatomic,strong)NSString *EduTime;
@property(nonatomic,strong)NSString *EduIcon;
@property(nonatomic,strong)NSFileManager *fileManager;
@property(nonatomic,strong)NSData *data;

@end

@implementation PerfourViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNav];
    [self perFtableview];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
}
-(void)perFtableview {
    _PerfTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
    _PerfTableView.delegate = self;
    _PerfTableView.dataSource = self;
    _per4Image = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width-95, 200, 85, 110)];
    _per4Image.backgroundColor = [UIColor redColor];
    [self.PerfTableView addSubview:_per4Image];
    [self.view addSubview:_PerfTableView];
   
}

//自定义导航栏
-(void)setUpNav
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,64)];
    
    navView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:navView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2 -80, 20, 160, 30)];
    
    title.text = @"完善个人资料4/5";
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
    [self.PerfTableView reloadData];
    [self Updata];
    PerFiveViewController *pertwoVC= [[PerFiveViewController alloc]init];
    [self.navigationController pushViewController:pertwoVC animated:YES];
    
}
-(void) searCh {
    [self.navigationController  popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strId = @"pCello";
    if (indexPath.section == 0) {
        PersoneTableViewCell *Pcell = [tableView dequeueReusableCellWithIdentifier:strId];
        Pcell =[[[NSBundle mainBundle]loadNibNamed:@"PersoneTableViewCell" owner:nil options:nil]lastObject];
        Pcell.name.text = @"学校";
        Pcell.Peron.text =  self.EduSchool;
        return Pcell;
    }else if (indexPath.section ==1){
        PeraTableViewCell *Pcell = [tableView dequeueReusableCellWithIdentifier:strId];
        Pcell =[[[NSBundle mainBundle]loadNibNamed:@"PeraTableViewCell" owner:nil options:nil]lastObject];
        if (indexPath.row == 0) {
            Pcell.Pera.text = @"学历";
            Pcell.Perl.text = self.EduStr;
        }
        else if (indexPath.row == 1){
            Pcell.Pera.text  = @"在校时间";
            Pcell.Perl.text =self.EduTime;
        }
        return Pcell;
    }
    
    else{
        PerTableViewCell *Pcell = [tableView dequeueReusableCellWithIdentifier:strId];
        Pcell =[[[NSBundle mainBundle]loadNibNamed:@"PerTableViewCell" owner:nil options:nil]lastObject];
        Pcell.PerImagV.image= self.per4Image.image;
        return Pcell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSInteger tag = indexPath.row;
    if (indexPath.section>1) {
        if (tag == 0) {
            UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"选择相片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"本地相册", nil];
            [action showInView:self.view];
        }
    }else if (indexPath.section ==0){
        SchoolViewController *schoolVC = [SchoolViewController new];
        schoolVC.NextSchool = ^(NSString *meStr){
            self.EduSchool=meStr;
            NSLog(@"%@",meStr);
            [self viewDidLoad];
        };
        [self.navigationController pushViewController:schoolVC animated:YES];
    }
    else if (indexPath.section==1){
        if (tag ==0) {
            EducViewController *EduVC= [EducViewController new];
            EduVC.nextEdu = ^(NSString *meStr){
                NSLog(@"%@",meStr);
                self.EduStr =meStr;
                [self viewDidLoad];
            };
            [self.navigationController pushViewController:EduVC animated:YES];
        }
        else if (tag==1){
            CCPPickerViewTwo *pickerViewTwo = [[CCPPickerViewTwo alloc] initWithpickerViewWithCenterTitle:@"选择时间" andCancel:@"取消" andSure:@"确定"];
            
            [pickerViewTwo pickerVIewClickCancelBtnBlock:^{
                NSLog(@"取消");
                
            } sureBtClcik:^(NSString *leftString, NSString *rightString, NSString *leftAndRightString) {
                
                NSLog(@"%@=======%@=======%@",leftString,rightString,leftAndRightString);
                self.EduTime =leftAndRightString;
                [self viewDidLoad];
            }];
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
    
//    UIImage *infoImage = info[UIImagePickerControllerEditedImage];
//    self.per4Image.image = infoImage;
    self.fileManager = [NSFileManager defaultManager];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image = [[UIImage alloc] init];
    if ([mediaType isEqualToString:@"public.image"]){
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [_per4Image setImage:image];
        //        [_changeBtn setImage:image forState:UIControlStateNormal];
        _data;
        
        if (UIImagePNGRepresentation(image) == nil) {
            
            _data = UIImageJPEGRepresentation(image, 1);
            
        } else {
            
            _data = UIImageJPEGRepresentation(image, 0.001); //压缩图片，方便上传
        }
        
        //       //获取文件路径
        
        NSString *imageString = [_data base64EncodedStringWithOptions:0];
        //        转成base64字符串imageString，再传给给后台，在传参中需要添加图片的类型（@“png”或@“jpg”等）
        [self.fileManager createFileAtPath:[imageString stringByAppendingString:@"/image.png"] contents:_data attributes:nil];  //将图片保存为PNG格式
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)Updata{
    NSString *url = @"http://118.89.45.205/users/updateTeacerEdu";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    NSDictionary *parameters = @{@"collage":@"2",
                                 @"edutime":@"2014-07",
                                 @"edu":@"ff"
                                 };
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        
        [formData appendPartWithFileData:self.data name:@"eduimg" fileName:fileName mimeType:@"image/png"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功：%@",responseObject);
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //获取路径
        NSLog(@"1111111%@",str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@",error);
    }];
}


- (void)saveChangeData {
    
    
//    _image4 = UIImagePNGRepresentation(self.per4Image.image);
    NSLog(@"保存");
    
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >1) {
        return 120;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0) {
        return 30;
    }else if (section == 1){
        return 0.0001;
    }else{
        return 30;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 200;
    }else{
        return 0.0001;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"请填写学历信息";
    }else if (section == 2)
    {
        return @"请上传学历证明或是职业资格证明";
    }else{
        return 0;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section>1) {
        return @"如果你是学生请上传你的学历证明，如果你是在职老师请上传职业资格证明，如果你是兼职老师请上传你的最高学历证明";
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForFooterInSection:section];
    if (sectionTitle  == nil) {
        return nil;
    }
    UILabel *lable = [[UILabel alloc]init];
    lable.frame =CGRectMake(20, -35, CGRectGetWidth(tableView.frame)-20, 120);
    lable.numberOfLines = 0;
    lable.shadowOffset = CGSizeMake(0.0, 1.0);
   lable.font = [UIFont boldSystemFontOfSize:14];
    lable.text = sectionTitle;
    
    UIView *view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 120)];
     view.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    [view addSubview:lable];
    return view;
}
@end
