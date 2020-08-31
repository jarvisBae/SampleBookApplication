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

#pragma mark - Set Data
- (void)setDisplayWithBook:(BookDisplay *)display {
    [self.labelTitle setText:display.title];
}

- (void)setDisplayWithSearchText:(SearchTextDisplay *)display {
    [self.labelTitle setText:display.text];
}

@end
