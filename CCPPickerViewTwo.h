//
//  CCPPickerViewTwo.h
//  CCPPickerView
//
//  Created by 古振坤 on 2017/1/21.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickCancelBtn)();

typedef void(^clickSureBtn)(NSString *leftString,NSString *rightString,NSString *leftAndRightString);

@interface CCPPickerViewTwo : UIView

@property (copy,nonatomic) void(^clickCancelBtn)();
@property (copy,nonatomic) void (^clickSureBtn)(NSString *leftString,NSString *rightString,NSString *leftAndRightString);

- (instancetype)initWithpickerViewWithCenterTitle:(NSString *)title andCancel:(NSString *)cancel andSure:(NSString *)sure;

- (void)pickerVIewClickCancelBtnBlock:(clickCancelBtn)cancelBlock
                          sureBtClcik:(clickSureBtn)sureBlock;

@end
