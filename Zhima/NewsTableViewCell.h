//
//  NewsTableViewCell.h
//  Zhima
//
//  Created by 古振坤 on 2017/1/12.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *texlable;
@property (weak, nonatomic) IBOutlet UIImageView *newsimage;
@property (weak, nonatomic) IBOutlet UILabel *namelable;
@property (weak, nonatomic) IBOutlet UILabel *tiemlable;

@end
