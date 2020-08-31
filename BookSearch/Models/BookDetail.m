//
//  BookDetail.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BookDetail.h"

@implementation BookDetail

#pragma mark - initialize
- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle authors:(NSString *)authors publisher:(NSString *)publisher language:(NSString *)language isbn10:(NSString *)isbn10 isbn13:(NSString *)isbn13 pages:(NSString *)pages year:(NSString *)year rating:(float)rating desc:(NSString *)desc price:(NSString *)price image:(NSString *)image url:(NSString *)url error:(BOOL)error {
        self = [super init];
        if (self) {
            self.title = title;
            self.subtitle = subtitle;
            self.authors = authors;
            self.publisher = publisher;
            self.language = language;
            self.isbn10 = isbn10;
            self.isbn13 = isbn13;
            self.pages = pages;
            self.year = year;
            self.rating = rating;
            self.desc = desc;
            self.price = price;
            self.image = image;
            self.url = url;
            self.error = error;
        }
        return self;
}

- (nullable NSURL *)imageUrl {
    return [NSURL URLWithString:self.image];
}
- (nullable NSURL *)bookUrl {
    return [NSURL URLWithString:self.url];
}


@end
