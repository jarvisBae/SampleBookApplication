//
//  BookDetailDisplay.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BookDetail;

@interface BookDetailDisplay : NSObject

@property (nonatomic, readonly) BOOL error;
@property (nonatomic, readonly, nullable) NSString *title;
@property (nonatomic, readonly, nullable) NSString *subtitle;
@property (nonatomic, readonly, nullable) NSString *authors;
@property (nonatomic, readonly, nullable) NSString *publisher;
@property (nonatomic, readonly, nullable) NSString *language;
@property (nonatomic, readonly, nullable) NSString *isbn10;
@property (nonatomic, readonly, nullable) NSString *isbn13;
@property (nonatomic, readonly, nullable) NSString *pages;
@property (nonatomic, readonly, nullable) NSString *year;
@property (nonatomic, readonly) float rating;
@property (nonatomic, readonly, nullable) NSString *desc;
@property (nonatomic, readonly, nullable) NSString *price;
@property (nonatomic, readonly, nullable) NSString *image;
@property (nonatomic, readonly, nullable) NSString *url;

- (instancetype)initWithBookDetail:(nonnull BookDetail*)bookDetail;

@end

NS_ASSUME_NONNULL_END
