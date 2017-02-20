//
//  PlaceholderTextView.h
//  Certificatio
//
//  Created by 古振坤 on 2017/2/4.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView
@property(nonatomic,strong) UILabel *placeHolderLabel;
@property(nonatomic,copy)NSString *placeholder;
@property(nonatomic,strong)UIColor *placeholderColor;
-(void)textChanged:(NSNotification *)notification;
@end
