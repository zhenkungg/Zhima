//
//  PhotofiveCollectionViewCell.m
//  Certificatio
//
//  Created by 古振坤 on 2017/2/4.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "PhotofiveCollectionViewCell.h"

@implementation PhotofiveCollectionViewCell


-(UIImageView *)photoV
{
    if (_photoV == nil) {
        self.photoV = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _photoV;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoV];
    }
    return self;
}


@end
