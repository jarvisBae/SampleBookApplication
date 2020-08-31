//
//  BookDisplay.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "BookDisplay.h"
#import "Book.h"


@interface BookDisplay()

@property (nonatomic, readwrite, nullable) NSString *title;
@property (nonatomic, readwrite, nullable) NSString *subtitle;
@property (nonatomic, readwrite, nullable) NSString *isbn13;
@property (nonatomic, readwrite, nullable) NSString *price;
@property (nonatomic, readwrite, nullable) NSString *image;
@property (nonatomic, readwrite, nullable) NSString *url;
@property (nonatomic, readwrite, nullable) UIImage *coverImage;

@end

@implementation BookDisplay

- (instancetype)initWithBook:(Book*)book {
    self = [super init];
    if (self) {
        self.title = book.title;
        self.subtitle = book.subtitle;
        self.isbn13 = book.isbn13;
        self.price = book.price;
        self.image = book.image;
        self.url = book.url;
    }
    return self;
}
@end
