//
//  BookDisplay.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Book;

@interface BookDisplay : NSObject

@property (nonatomic, readonly, nullable) NSString *title;
@property (nonatomic, readonly, nullable) NSString *subtitle;
@property (nonatomic, readonly, nullable) NSString *isbn13;
@property (nonatomic, readonly, nullable) NSString *price;
@property (nonatomic, readonly, nullable) NSString *image;
@property (nonatomic, readonly, nullable) NSString *url;
@property (nonatomic, readonly, nullable) UIImage *coverImage;

- (instancetype)initWithBook:(nonnull Book*)book;

@end

NS_ASSUME_NONNULL_END
