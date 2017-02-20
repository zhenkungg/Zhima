//
//  UIControl+Add.h
//  Zhima
//
//  Created by Json on 2017/1/14.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Add)

-(void)removeAllTargets;

- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

- (void)setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

- (void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;

@end
