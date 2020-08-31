//
//  BookTableViewCell.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "BookTableViewCell.h"
#import "BookDisplay.h"
#import "SearchTextDisplay.h"

@implementation BookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDisplayWithBook:(BookDisplay *)display {
    [self.labelTitle setText:display.title];
}

- (void)setDisplayWithSearchText:(SearchTextDisplay *)display {
    [self.labelTitle setText:display.text];
}

@end
