//
//  SearchMainDisplay.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/29.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "SearchTextDisplay.h"
#import "SearchText.h"

@interface SearchTextDisplay()

@property (nonatomic, readwrite, nullable) NSString *text;
@property (nonatomic, readwrite, nullable) NSDate *date;

@end


@implementation SearchTextDisplay

- (instancetype)initWithSearchText:(SearchText *)searchText {
    self = [super init];
    if (self) {
        self.text = searchText.text;
        self.date = searchText.date;
    }
    return self;
}

@end
