//
//  PerFiveViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/2/4.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "PerFiveViewController.h"
#import "PlaceholderTextView.h"
#import "PhotofiveCollectionViewCell.h"
#define kTextBorderColor RGBCOLOR(227,244,216)

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface PerFiveViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) PlaceholderTextView *textView;
@property(nonatomic,strong) UIButton *sendButton;
@property(nonatomic,strong) UIView *aView;
@property (nonatomic, strong)UICollectionView *collectionV;
//上传图片的个数
@property (nonatomic, strong)NSMutableArray *photoArrayM;
//上传图片的button
@property (nonatomic, strong)UIButton *photoBtn;
//回收键盘
@property (nonatomic, strong)UITextField *textField;

//字数的限制
@property (nonatomic, strong)UILabel *wordCountLabel;

@property(nonatomic,strong)UITextView *HonorTF;
@property(nonatomic,strong)NSString *HonorIcon;

@end

@implementation PerFiveViewController

//懒加载数组
- (NSMutableArray *)photoArrayM{
    if (!_photoArrayM) {
        _photoArrayM = [NSMutableArray arrayWithCapacity:0];
    }
    return _photoArrayM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1.0f];
    self.aView = [[UIView alloc]init];
    _aView.backgroundColor = [UIColor whiteColor];
    _aView.frame = CGRectMake(20, 84, self.view.frame.size.width - 40, 180);
    [self.view addSubview:_aView];
    self.navigationItem.title = @"获得荣誉介绍";
    
    self.HonorTF = [[UITextView alloc]initWithFrame:self.textView.frame];
    self.wordCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.textView.frame.origin.x + 20,  self.textView.frame.size.height + 84 - 1, [UIScreen mainScreen].bounds.size.width - 40, 20)];
    _wordCountLabel.font = [UIFont systemFontOfSize:14.f];
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.text = @"0/300";
    self.wordCountLabel.backgroundColor = [UIColor whiteColor];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.textView.frame.origin.x + 20,  self.textView.frame.size.height + 84 - 1 + 23, [UIScreen mainScreen].bounds.size.width - 40, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    [self.aView addSubview:self.HonorTF];
    [self.view addSubview:_wordCountLabel];
    [_aView addSubview:self.textView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    //添加一个label(图（选填）)
    [self addLabelText];
    
    //创建collectionView进行上传图片
    
    [self addCollectionViewPicture];
    
    //提交信息的button
    [self.view addSubview:self.sendButton];
    
    //上传图片的button
    self.photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoBtn.frame = CGRectMake(10 , 165, (self.aView.frame.size.width- 60) / 5, (self.aView.frame.size.width- 60) / 5);
    [_photoBtn setImage:[UIImage imageNamed:@"2.4意见反馈_03(1)"] forState:UIControlStateNormal];
    
    [_photoBtn addTarget:self action:@selector(picureUpload:) forControlEvents:UIControlEventTouchUpInside];
    [self.aView addSubview:_photoBtn];
    [self setUpNav];
    
}
///图片上传
-(void)picureUpload:(UIButton *)sender{
    
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    picker.allowsEditing=YES;
    picker.delegate=self;
    [self presentViewController:picker animated:YES completion:nil];
    
}
//上传图片的协议与代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    //    [self.btn setImage:image forState:UIControlStateNormal];
    [self.photoArrayM addObject:image];
    //选取完图片之后关闭视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

//button的frame
-(void)viewWillAppear:(BOOL)animated{
    if (self.photoArrayM.count < 5) {
        
        [self.collectionV reloadData];
        _aView.frame = CGRectMake(20, 84, self.view.frame.size.width - 40, 180);
        self.photoBtn.frame = CGRectMake(10 * (self.photoArrayM.count + 1) + (self.aView.frame.size.width - 60) / 5 * self.photoArrayM.count, 154 - 5, (self.aView.frame.size.width - 60) / 5, (self.aView.frame.size.width - 60) / 5 + 5);
    }else{
        [self.collectionV reloadData];
        self.photoBtn.frame = CGRectMake(0, 0, 0, 0);
        
    }
    
}

-(void)addLabelText{
    UILabel * labelText = [[UILabel alloc] init];
    labelText.text = @"荣誉证书(选填)";
    labelText.frame = CGRectMake(10, 125,[UIScreen mainScreen].bounds.size.width - 20, 20);
    labelText.font = [UIFont systemFontOfSize:14.f];
    labelText.textColor = _textView.placeholderColor;
    [_aView addSubview:labelText];
    
    
}
#pragma mark 上传图片UIcollectionView

-(void)addCollectionViewPicture{
    //创建一种布局
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc]init];
    //设置每一个item的大小
    flowL.itemSize = CGSizeMake((self.aView.frame.size.width - 60) / 5 , (self.aView.frame.size.width - 60) / 5 );
    flowL.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    //列
    flowL.minimumInteritemSpacing = 10;
    //行
    flowL.minimumLineSpacing = 10;
    //创建集合视图
    self.collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 145, self.aView.frame.size.width, ([UIScreen mainScreen].bounds.size.width - 60) / 5 + 10) collectionViewLayout:flowL];
    _collectionV.backgroundColor = [UIColor whiteColor];
    // NSLog(@"-----%f",([UIScreen mainScreen].bounds.size.width - 60) / 5);
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    //添加集合视图
    [self.aView addSubview:_collectionV];
    
    //注册对应的cell
    [_collectionV registerClass:[PhotofiveCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

-(PlaceholderTextView *)textView{
    
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 100)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = kTextBorderColor.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _textView.placeholder = @"写下你的自我荣誉介绍，让同学们更好地选择你";
       
    }
    
    return _textView;
}

//把回车键当做退出键盘的响应键  textView退出键盘的操作
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (UIButton *)sendButton{
    
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.layer.cornerRadius = 2.0f;
        _sendButton.frame = CGRectMake(20, 364, self.view.frame.size.width - 40, 40);
        _sendButton.backgroundColor = [self colorWithRGBHex:0x60cdf8];
        [_sendButton setTitle:@"提交" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendFeedBack) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendButton;
    
}

#pragma mark 提交意见反馈
- (void)sendFeedBack{
    if (self.textView.text.length == 0) {
        
        UIAlertController *alertLength = [UIAlertController alertControllerWithTitle:@"提示" message:@"你输入的信息为空，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *suer = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertLength addAction:suer];
        [self presentViewController:alertLength animated:YES completion:nil];
        
        
        
    }
}

#pragma mark textField的字数限制

//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger wordCount = textView.text.length;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/300",(long)wordCount];
   
    [self wordLimit:textView];
}
#pragma mark 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 300) {
        NSLog(@"%ld",text.text.length);
     
        self.HonorTF.text = text.text;
           NSLog(@"%@",self.HonorTF.text);
        self.textView.editable = YES;
        
    }
    else{
        self.textView.editable = NO;
        
    }
    return nil;
}
- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

#pragma mark CollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_photoArrayM.count == 0) {
        return 0;
    }
    else{
        return _photoArrayM.count;
    }
}

//返回每一个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   PhotofiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.photoV.image = self.photoArrayM[indexPath.item];
    return cell;
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [_textView resignFirstResponder];
//    [_textField resignFirstResponder];
//    
//}

//自定义导航栏
-(void)setUpNav
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,64)];
    
    navView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:navView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2 -80, 20, 160, 30)];
    
    title.text = @"完善个人资料5/5";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    [self.view addSubview:title];
    UIButton *search1 = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-80-10, 20, 65, 40)];
    [search1 setTitle:@"完成" forState:UIControlStateNormal];
    
    UIButton *search = [[UIButton alloc]initWithFrame:CGRectMake(30, 20, 40, 40)];
    
    [search setImage:[UIImage imageNamed:@"mazoo-logo"] forState:UIControlStateNormal];
    [ search1 addTarget:self action:@selector(searCh1) forControlEvents:UIControlEventTouchUpInside ];
    [ search addTarget:self action:@selector(searCh) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:search1];
    [self.view addSubview:search];
    
}
-(void)searCh1 {
    PerFiveViewController *pertwoVC= [[PerFiveViewController alloc]init];
    [self.navigationController pushViewController:pertwoVC animated:YES];
    
}
-(void) searCh {
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
