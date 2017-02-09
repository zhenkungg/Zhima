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

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ChangeDelegate>

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
-(void)searCh1 {
    [self.PonetableView reloadData];
    NSLog(@"1%@,1%@,1%@",self.perName,self.perGender,self.perAddress);
    PerstontwoViewController *pertwoVC= [[PerstontwoViewController alloc]init];
    [self.navigationController pushViewController:pertwoVC animated:YES];
    
}
-(void)searCh {
    [self.navigationController  popViewControllerAnimated:YES];
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
        return 2;
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
            [Pcell setBlock:^(NSString * TextNa) {
                self.perName = TextNa;

            }];

//            Pcell.Peron.text = self.perName;
        }else if (indexPath.row == 1) {
            Pcell.name.text = @"性别";
            Pcell.Peron.text = self.perGender;
            [Pcell setBlock:^(NSString *TextName) {
                self.perGender = TextName;
            }];
  
        }
        return Pcell;
        }
     else  {
        PeraTableViewCell *Pcell = [tableView dequeueReusableCellWithIdentifier:strId];
        Pcell =[[[NSBundle mainBundle]loadNibNamed:@"PeraTableViewCell" owner:nil options:nil]lastObject];
        if (indexPath.row ==0) {
            Pcell.Perl.text = @"地址";
            Pcell.Pera.text = self.perAddress;
        }else if (indexPath.row == 1) {
            Pcell.Perl.text = @"自我介绍";
            Pcell.Pera.text = self.perPlace;
        }
       
   return Pcell;
    }
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
               NSIndexPath *path =[NSIndexPath indexPathForRow:0 inSection:2];
               [_PonetableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
           };
           
       } else if (tag ==1)
       {
           BlockTextViewController * BlockVC = [BlockTextViewController new];
           
           //当且仅当nextVCBlock在A中被调用时，block内部才会被执行,此作用一是初始化nextVCBlock，而是获取值
           BlockVC.NextBt= ^(NSString * meStr){
               NSLog(@"我是block传来的值 == %@",meStr);
               self.perPlace =@"已填写";
               NSIndexPath *path =[NSIndexPath indexPathForRow:1 inSection:2];
               [_PonetableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path, nil] withRowAnimation:UITableViewRowAnimationNone];
               
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
    
//    UIImage *infoImage = info[UIImagePickerControllerEditedImage];
//    self.perImage.image = infoImage;
//    [self saveChangeData];
//    [self dismissViewControllerAnimated:YES completion:nil];
    NSFileManager *fileManager = [NSFileManager defaultManager];
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
        [fileManager createFileAtPath:[imageString stringByAppendingString:@"/image.png"] contents:data attributes:nil];  //将图片保存为PNG格式
        
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
