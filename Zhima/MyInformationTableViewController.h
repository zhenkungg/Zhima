//
//  MyInformationTableViewController.h
//  Zhima
//
//  Created by Json on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonViewController.h"
@interface MyInformationTableViewController : UITableViewController
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)PersonViewController *delegate;
@end
