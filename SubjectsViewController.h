//
//  SubjectsViewController.h
//  Certificatio
//
//  Created by 古振坤 on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^NextSub)(NSString *SubLe);
@interface SubjectsViewController : UIViewController
@property(copy,nonatomic)NextSub nextSub;

@end