//
//  SchoolTimeViewController.h
//  Certificatio
//
//  Created by 古振坤 on 2017/1/21.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^nextsT)(NSString *school);

@interface SchoolTimeViewController : UIViewController

@property(copy,nonatomic)nextsT NextSt;
@end
