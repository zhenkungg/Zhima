//
//  BlockViewController.h
//  Certificatio
//
//  Created by 古振坤 on 2017/1/17.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^NextVCBlock)(NSString *textField);

@interface BlockViewController : UIViewController

@property(nonatomic,copy)NextVCBlock nextVCBlock;

@end
