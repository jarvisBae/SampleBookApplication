//
//  Book.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject<NSSecureCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *isbn13;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *url;

- (instancetype)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle isbn13:(NSString*)isbn13 price:(NSString*)price image:(NSString*)image url:(NSString*)url;

- (nullable NSURL*)bookUrl;
- (nullable NSURL*)imageUrl;

@end

NS_ASSUME_NONNULL_END
