//
//  UserInfo.m
//  lianxi01
//
//  Created by 王勇 on 16/3/27.
//  Copyright © 2016年 Brave. All rights reserved.
//

#import "UserInfo.h"
#define genderKEY @"gender"
#define youKEY @"yourname"
#define headKEY @"image"
#define per3iKEY @"p3imga"
@implementation UserInfo
singleton_implementation(UserInfo)


- (void)saveUserInofFromSanbox{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.gender forKey:genderKEY];
    [defaults setValue:self.yourName forKey:youKEY];
    [defaults setObject:self.imageData forKey:headKEY];
    [defaults setObject:self.image3Data forKey:per3iKEY];
    [defaults synchronize];
}

- (void)loadUserInofFromSanbox{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   self.gender = [defaults objectForKey:genderKEY];
   self.yourName = [defaults objectForKey:youKEY];
    self.imageData = [defaults objectForKey:headKEY];
    self.image3Data = [defaults objectForKey:per3iKEY];
}

@end
