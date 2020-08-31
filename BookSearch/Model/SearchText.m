//
//  SearchText.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/29.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "SearchText.h"

@implementation SearchText

- (instancetype)initWithSearchText:(NSString *)text date:(NSDate *)date {
    self = [super init];
    if (self) {
        self.text = text;
        self.date = date;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.text forKey:@"text"];
    [coder encodeObject:self.date forKey:@"date"];
}
- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self != nil) {
        self.text = [coder decodeObjectOfClass:[SearchText class] forKey:@"text"];
        self.date = [coder decodeObjectOfClass:[NSDate class] forKey:@"date"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}



@end
