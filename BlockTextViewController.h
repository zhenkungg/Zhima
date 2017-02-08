//
//  BlockTextViewController.h
//  Certificatio
//
//  Created by 古振坤 on 2017/1/19.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>


 typedef void(^NextTB)(NSString *textView);
@interface BlockTextViewController : UIViewController

@property(copy ,nonatomic) NextTB NextBt;

@end
