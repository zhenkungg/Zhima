//
//  MyInformationTableViewController.m
//  Zhima
//
//  Created by Json on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "MyInformationTableViewController.h"
#import "MyInformationCell.h"
#import "PersonViewController.h"
@interface MyInformationTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MyInformationTableViewController

-(UIImage *)image{
    if (_image == nil) {
        _image = [UIImage imageNamed:@"HeaderImage"];
    }
    return _image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    self.delegate.image = self.image;
    [self.delegate mysetImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }else
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        MyInformationCell *newcell = [[NSBundle mainBundle] loadNibNamed:@"MyInformationCell" owner:nil options:nil][0];
        newcell.headerImageView.image = self.image;
        cell = newcell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"MyInformationCell" owner:nil options:nil][1];
        }else
            cell = [[NSBundle mainBundle] loadNibNamed:@"MyInformationCell" owner:nil options:nil][2];
    }else
        cell = [[NSBundle mainBundle] loadNibNamed:@"MyInformationCell" owner:nil options:nil][3];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 59;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 53;
        }else
            return 54;
    }else
        return 77;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0&&indexPath.row == 0) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark UIImagePickerController 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        self.image = [info objectForKey:UIImagePickerControllerEditedImage];
        [self.tableView reloadData];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
