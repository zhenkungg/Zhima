//
//  IDcardViewController.h
//  Certificatio
//
//  Created by 古振坤 on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^NextID)(NSString *texf);
@interface IDcardViewController : UIViewController

@property(copy,nonatomic)NextID nextid;
@end
