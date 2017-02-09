//
//  PersoneTableViewCell.m
//  Certificatio
//
//  Created by 古振坤 on 2017/1/16.
//  Copyright © 2017年 zkgg. All rights reserved.
//

#import "PersoneTableViewCell.h"


@interface PersoneTableViewCell () <UITextFieldDelegate>

@end

@implementation PersoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.Peron.delegate = self;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.Block) {
        self.Block (textField.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
