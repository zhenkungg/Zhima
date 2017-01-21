//
//  HeaderView.m
//  Zhima
//
//  Created by Json on 2017/1/20.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (IBAction)gotoMyInformation:(id)sender {
    [self.delegate pushToMyInformationVC];
}


@end
