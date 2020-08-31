//
//  Book.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//
#import "Book.h"

@implementation Book

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle isbn13:(NSString *)isbn13 price:(NSString *)price image:(NSString *)image url:(NSString *)url {
    self = [super init];
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
        self.isbn13 = isbn13;
        self.price = price;
        self.image = image;
        self.url = url;
    }
    return self;
}

- (nullable NSURL *)imageUrl {
    return [NSURL URLWithString:self.image];
}
- (nullable NSURL *)bookUrl {
    return [NSURL URLWithString:self.url];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.subtitle forKey:@"subtitle"];
    [coder encodeObject:self.isbn13 forKey:@"isbn13"];
    [coder encodeObject:self.price forKey:@"price"];
    [coder encodeObject:self.image forKey:@"image"];
    [coder encodeObject:self.url forKey:@"url"];
}
- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self != nil) {
        self.title = [coder decodeObjectOfClass:[Book class] forKey:@"title"];
        self.subtitle = [coder decodeObjectOfClass:[Book class] forKey:@"subtitle"];
        self.isbn13 = [coder decodeObjectOfClass:[Book class] forKey:@"isbn13"];
        self.price = [coder decodeObjectOfClass:[Book class] forKey:@"price"];
        self.image = [coder decodeObjectOfClass:[Book class] forKey:@"image"];
        self.url = [coder decodeObjectOfClass:[Book class] forKey:@"url"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}



@end
