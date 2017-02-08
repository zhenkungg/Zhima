//
//  SchoolViewController.h
//  Certificatio
//
//  Created by 古振坤 on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NetSchool)(NSString *school);
@interface SchoolViewController : UIViewController
@property(nonatomic,copy) NetSchool NextSchool;
@end
