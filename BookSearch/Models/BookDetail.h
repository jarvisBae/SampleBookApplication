//
//  BookDetail.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface BookDetail : NSObject

@property (nonatomic) BOOL error;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *authors;
@property (nonatomic, strong) NSString *publisher;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *isbn10;
@property (nonatomic, strong) NSString *isbn13;
@property (nonatomic, strong) NSString *pages;
@property (nonatomic, strong) NSString *year;
@property (nonatomic) float rating;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *url;

- (instancetype)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle authors:(NSString*)authors publisher:(NSString*)publisher language:(NSString*)language isbn10:(NSString*)isbn10 isbn13:(NSString*)isbn13 pages:(NSString*)pages year:(NSString*)year rating:(float)rating desc:(NSString*)desc price:(NSString*)price image:(NSString*)image url:(NSString*)url error:(BOOL)error;

- (nullable NSURL*)bookUrl;
- (nullable NSURL*)imageUrl;

@end

NS_ASSUME_NONNULL_END
