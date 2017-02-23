//
//  LBTabBar.h
//  Zhima
//
//  Created by 古振坤 on 2017/1/11.
//  Copyright © 2017年 zkgg. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@class LBTabBar;

@protocol LBTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar;
@end


@interface LBTabBar : UITabBar

/** tabbar的代理 */
@property (nonatomic, weak) id<LBTabBarDelegate> myDelegate ;

@end
