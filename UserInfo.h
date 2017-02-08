//
//  UserInfo.h
//  lianxi01
//
//  Created by 王勇 on 16/3/27.
//  Copyright © 2016年 Brave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface UserInfo : NSObject
singleton_interface(UserInfo)
@property (nonatomic ,copy) NSString *gender;
@property (nonatomic ,copy) NSString *yourName;
@property (nonatomic ,strong) NSData *imageData;
@property(nonatomic,strong)NSData *image3Data;

- (void)saveUserInofFromSanbox;

- (void)loadUserInofFromSanbox;
@end
