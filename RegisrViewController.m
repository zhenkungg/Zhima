//
//  RegisrViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/14.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "RegisrViewController.h"
#import "PersonalViewController.h"
#import "AgreementViewController.h"

#define  LR_Width  [UIScreen mainScreen].bounds.size.width
#define  LR_Height [UIScreen mainScreen].bounds.size.height
@interface RegisrViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *acctF;
@property (nonatomic, strong) UITextField *pwdtF;
@property (nonatomic, strong) UIButton *yesBut;
@property (nonatomic, strong) UIButton *nextBut;
@property (nonatomic, strong) UIImageView *accBG;
@property (nonatomic, strong) UIImageView *pwdBG;
@property (nonatomic, strong) UILabel *TextLa;
@property (nonatomic, strong) UIButton *TextBut;

@end

@implementation RegisrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self reloadview];
    // Do any additional setup after loading the view.
}
-(void)reloadview{
    self.acctF = [[UITextField alloc]initWithFrame:CGRectMake(LR_Width/5, 115, LR_Width/4*3, 35)];
    self.acctF.backgroundColor = [UIColor whiteColor];
    self.acctF.borderStyle = UITextBorderStyleRoundedRect;
    self.acctF.placeholder = @"请输入手机号码";
    
    self.pwdtF = [[UITextField alloc]initWithFrame:CGRectMake(LR_Width/5, 180, LR_Width/4*3, 35)];
    self.pwdtF.backgroundColor = [UIColor whiteColor];
    self.pwdtF.borderStyle = UITextBorderStyleRoundedRect;
    self.pwdtF.placeholder = @"请输入密码";
    self.pwdtF.secureTextEntry = YES;
    
    self.accBG = [[UIImageView alloc]initWithFrame:CGRectMake(LR_Width/5-35, 115, 30, 30)];
    self.accBG.image = [UIImage imageNamed:@"iconfont-user"];
    self.pwdBG = [[UIImageView alloc]initWithFrame:CGRectMake(LR_Width/5-35, 180, 30, 30)];
    self.pwdBG.image = [UIImage imageNamed:@"iconfont-password"];
    
    
    self.yesBut = [[UIButton alloc]initWithFrame:CGRectMake(LR_Width/4-20, LR_Height/2, 35, 35)];
    [self.yesBut setImage:[UIImage imageNamed:@"iconfont-password"] forState:UIControlStateNormal];
    [self.yesBut setImage:[UIImage imageNamed:@"iconfont-user"] forState:UIControlStateSelected];
    [self.yesBut addTarget:self action:@selector(chaad) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextBut = [[UIButton alloc]initWithFrame:CGRectMake(LR_Width/4, LR_Height/2-50, LR_Width/2, 35)];
    self.nextBut.backgroundColor = [UIColor blueColor];
    [self.nextBut setTitle:@"完成，并完善个人资料" forState:UIControlStateNormal];
    self.nextBut.userInteractionEnabled = NO;
    self.nextBut.alpha = 0.5;
    [self.nextBut addTarget:self action:@selector(perBut) forControlEvents:UIControlEventTouchUpInside];
    
    self.TextLa = [[UILabel alloc]initWithFrame:CGRectMake(LR_Width/4+15, LR_Height/2, 100, 35)];
    self.TextLa.text = @"我已经同意";
    self.TextBut = [[UIButton alloc]initWithFrame:CGRectMake(LR_Width/4+90, LR_Height/2,165, 35)];
    [self.TextBut setTitle:@"《芝麻学堂协议》" forState:UIControlStateNormal];
    [self.TextBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.TextBut addTarget:self action:@selector(attribut) forControlEvents:UIControlEventTouchUpInside];
    //设置通知
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:_acctF ];
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UITextFieldTextDidChangeNotification object:_pwdtF ];
    
    
    [self.view addSubview:self.TextBut];
    [self.view addSubview:self.TextLa];
    [self.view addSubview:self.acctF];
    [self.view addSubview:self.pwdtF];
    [self.view addSubview:self.yesBut];
    [self.view addSubview:self.nextBut];
    [self.view addSubview:self.accBG];
    [self.view addSubview:self.pwdBG];
    
}
-(void)perBut {
    PersonalViewController *pervc= [[PersonalViewController alloc]init];
    [self.navigationController pushViewController:pervc animated:YES];
}
-(void)attribut {
    AgreementViewController *agrVC = [[AgreementViewController alloc]init];
    [self.navigationController pushViewController:agrVC animated:YES];
}
-(void)chaad{
    [self valiMobile:self.acctF.text];
    
    
    NSUInteger tag = !_yesBut.selected;
    if (tag) {
        _yesBut.selected = !_yesBut.selected;
        NSLog(@"1");
        self.nextBut.userInteractionEnabled = YES;
        self.nextBut.alpha = 1.0;
        
    }else
    {
        _yesBut.selected = !_yesBut.selected;
        NSLog(@"2");
        self.nextBut.userInteractionEnabled = NO;
        self.nextBut.alpha = 0.5;
        
    }
    
    
}
-(void)change:(NSNotification *)notificantion{
    
    if (_acctF.text.length > 0 && _pwdtF.text.length > 0 ) {
        
    }else{
        self.nextBut.userInteractionEnabled = NO;
        self.nextBut.alpha = 0.5;
        
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
