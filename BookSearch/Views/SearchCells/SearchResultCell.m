//
//  SearchResultCell.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/25.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "SearchResultCell.h"
#import "BookDisplay.h"
#import "Functions.h"

@implementation SearchResultCell

#pragma mark - Set Data
- (void)setDisplay:(BookDisplay *)display setText:(NSString *)searchText {
    if (display.title != nil) {
        [self.labelTitle setText:display.title];
        [self.labelTitle highlight:display.title withChangeText:searchText];
    }
}


@end
