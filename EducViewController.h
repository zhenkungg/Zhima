//
//  EducViewController.h
//  Certificatio
//
//  Created by 古振坤 on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^nextEdu)(NSString * lebelTe);
@interface EducViewController : UIViewController
@property(copy,nonatomic)nextEdu nextEdu;
@end
