//
//  PerThreeViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/17.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "PerThreeViewController.h"
#import "PersoneTableViewCell.h"
#import "Per3TableViewCell.h"
#import "PerfourViewController.h"
#import "UserInfo.h"
#import "IDcardViewController.h"
#import "TNameViewController.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface PerThreeViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)IDcardViewController *IdBlock;
@property(nonatomic,strong)TNameViewController *TNaBlock;
@property(nonatomic,strong )UITableView *Per3tableview;
@property(nonatomic,strong)NSArray *Per3Arr;
@property(nonatomic,strong) UIImageView *pere3Image;
@property(nonatomic,strong)NSData *image3;
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *UserId;
@property(nonatomic,strong)NSString *UserIcon;

@end

@implementation PerThreeViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
     self.view.translatesAutoresizingMaskIntoConstraints= NO;
    [self setUpNav];
 
    [self Per3TableView];
    
}
-(void)Per3TableView{
    _Per3tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
    _Per3tableview.delegate = self;
    _Per3tableview.dataSource = self;
    [self.view addSubview:_Per3tableview];
    _pere3Image = [[UIImageView alloc]init];
    _pere3Image.frame =CGRectMake(Screen_Width-185, 200, 180, 175);
    _pere3Image.backgroundColor = [UIColor redColor];
 
    [self.Per3tableview addSubview:_pere3Image];
//    self.pere3Image.image =[UIImage imageWithData:_image3];
}
//自定义导航栏
-(void)setUpNav
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,64)];
    
    navView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:navView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2 -80, 20, 160, 30)];
    
    title.text = @"完善个人资料3/5";
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
    PerfourViewController *pertwoVC= [[PerfourViewController alloc]init];
    [self.navigationController pushViewController:pertwoVC animated:YES];
    
}
-(void) searCh {
    [self.navigationController  popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        if (section == 0) {
            return 2;
        }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strId = @"pCello";
    if (indexPath.section == 0) {
        PersoneTableViewCell *Pcell = [tableView dequeueReusableCellWithIdentifier:strId];
        Pcell =[[[NSBundle mainBundle]loadNibNamed:@"PersoneTableViewCell" owner:nil options:nil]lastObject];
        if (indexPath.row ==0) {
            Pcell.name.text  = @"个人真实姓名";
            Pcell.Peron.text= self.UserName;
            [Pcell setBlock:^(NSString *TextName) {
                self.UserName = TextName;
            }];
          NSLog( @"ff%@",self.UserName);
        }else if (indexPath.row == 1)
        {
            Pcell.name.text = @"身份证号码";
            Pcell.Peron.text = self.UserId;
            [Pcell setBlock:^(NSString *TextName) {
                self.UserId = TextName;
                [self CheckIsIdentityCard:self.UserId];
            }];
            NSLog( @"ff%@",self.UserId);

        }

        Pcell.textLabel.text = _Per3Arr[indexPath.row];
        
         return Pcell;
    }else{
    Per3TableViewCell *Pcell = [tableView dequeueReusableCellWithIdentifier:strId];
    Pcell =[[[NSBundle mainBundle]loadNibNamed:@"Per3TableViewCell" owner:nil options:nil]lastObject];
        Pcell.imageView.image= self.pere3Image.image;
    return Pcell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        if (indexPath.row == 0) {
//            TNameViewController *TnaVc= [TNameViewController new];
//            TnaVc.nextName=^(NSString *meStr){
//               
//                self.UserName= meStr;
//                NSLog( @"fsf%@",self.UserName);
//                [self viewDidLoad];
//                
//            };
//            [self.navigationController pushViewController:TnaVc animated:YES];
        }
        else if (indexPath.row==1)
        {
//            IDcardViewController *IDCVC= [IDcardViewController new];
//            IDCVC.nextid = ^(NSString *meStr){
//                self.UserId = meStr;
//                  [self checkIdentityCardNo:self.UserId];
//                NSLog( @"ff%@",self.UserId);
//                [self viewDidLoad];
//            };
//            [self.navigationController pushViewController:IDCVC animated:YES];
        }
    }
    
    else if (indexPath.section == 1) {
        NSInteger tag       = indexPath.row;
        if (tag == 0) {
            UIActionSheet *action               = [[UIActionSheet alloc] initWithTitle:@"选择相片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"本地相册", nil];
            [action showInView:self.view];
        }
    }
}

//身份证号
- (BOOL)CheckIsIdentityCard: (NSString *)identityCard
{
    if (identityCard.length != 18) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起!身份证的位数不够或过多" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return  NO;
    }
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
       
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"生日不合法" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"身份证错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你输入的身份证无效" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [alert show];
                return NO;
            }
        }
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你输入的身份证无效" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
  
    return NO;
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
    
    UIImage *infoImage = info[UIImagePickerControllerEditedImage];
    self.pere3Image.image = infoImage;
   [self saveChangeData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)saveChangeData {
    
    
//    [UserInfo sharedUserInfo].gender = self.gende.text;
    //    [UserInfo sharedUserInfo].yourName = self.youName.text;
//  _image3 = UIImagePNGRepresentation(self.pere3Image.image);
//    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
    NSLog(@"保存");
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >0) {
        return 230;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section >0) {
        return 300;
    }
    return 1;
}
//设置tableviewfooter的文本
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForFooterInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init] ;
    label.frame = CGRectMake(20, -25, CGRectGetWidth(tableView.frame)-20, 120);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithHue:(136.0/360.0)  // Slightly bluish green
                                 saturation:1.0
                                 brightness:0.60
                                      alpha:1.0];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:16];
    label.numberOfLines = 0;
    label.text = sectionTitle;
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 120)];
    view.backgroundColor=[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    [view addSubview:label];
    
    return view;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"请填写真实身份信息";
    }else{
        return @"请手持身份证照片";
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section>0){
        NSString *str1= @"1.照片为身份证正面与本人的头部合影";
        NSString *str2= @"2.照片质量需确保放大后，文本信息和证件号清晰";
        NSString *str3= @"3.照片需真实有效，不得做任何修改";
         str1 = [str1 stringByAppendingFormat :@"\n%@\n%@",str2,str3];
        NSLog(@"%@",str1);
    return  str1;

    }
    return 0;
}
@end
