//
//  HeaderView.h
//  Zhima
//
//  Created by Json on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonViewController.h"
@interface HeaderView : UIView
@property (nonatomic,strong)PersonViewController *delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
