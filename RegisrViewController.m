//
//  RegisrViewController.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/14.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "RegisrViewController.h"
#import "PersonalViewController.h"

@interface RegisrViewController ()

@end

@implementation RegisrViewController

- (IBAction)regist:(id)sender {
    PersonalViewController *pervc= [[PersonalViewController alloc]init];
    [self.navigationController pushViewController:pervc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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
