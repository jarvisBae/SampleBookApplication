//
//  BookDetailDisplay.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "BookDetailDisplay.h"
#import "BookDetail.h"


@interface BookDetailDisplay()

#pragma mark - property
@property (nonatomic, readwrite) BOOL error;
@property (nonatomic, readwrite, nullable) NSString *title;
@property (nonatomic, readwrite, nullable) NSString *subtitle;
@property (nonatomic, readwrite, nullable) NSString *authors;
@property (nonatomic, readwrite, nullable) NSString *publisher;
@property (nonatomic, readwrite, nullable) NSString *language;
@property (nonatomic, readwrite, nullable) NSString *isbn10;
@property (nonatomic, readwrite, nullable) NSString *isbn13;
@property (nonatomic, readwrite, nullable) NSString *pages;
@property (nonatomic, readwrite, nullable) NSString *year;
@property (nonatomic, readwrite) float rating;
@property (nonatomic, readwrite, nullable) NSString *desc;
@property (nonatomic, readwrite, nullable) NSString *price;
@property (nonatomic, readwrite, nullable) NSString *image;
@property (nonatomic, readwrite, nullable) NSString *url;

@end

@implementation BookDetailDisplay

#pragma mark - initialize
- (instancetype)initWithBookDetail:(BookDetail*)bookDetail  {
    self = [super init];
    if (self) {
        self.error = bookDetail.error;
        self.title = bookDetail.title;
        self.subtitle = bookDetail.subtitle;
        self.authors = bookDetail.authors;
        self.publisher = bookDetail.publisher;
        self.language = bookDetail.language;
        self.isbn10 = bookDetail.isbn10;
        self.isbn13 = bookDetail.isbn13;
        self.pages = bookDetail.pages;
        self.year = bookDetail.year;
        self.rating = bookDetail.rating;
        self.desc = bookDetail.desc;
        self.price = bookDetail.price;
        self.image = bookDetail.image;
        self.url = bookDetail.url;
    }
    return self;
}
@end
