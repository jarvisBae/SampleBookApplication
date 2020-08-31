//
//  ServerAPI.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BookDelegate.h"

#define SEARCH_LIST_BASE        [NSString stringWithFormat:@"https://api.itbook.store/1.0/search/"]
#define BOOK_DETAIL_BASE        [NSString stringWithFormat:@"https://api.itbook.store/1.0/books/"]

NS_ASSUME_NONNULL_BEGIN

typedef void(^ServerAPICompletionHandler)(id _Nullable metaData, NSError * _Nullable error);

@interface ServerAPI : NSObject<BookFetcherDelegate, BookCacheDelegate>

+ (instancetype _Nullable)manager;

- (instancetype)initWithParser:(id<BookParserDelegate>)parser;
- (instancetype)initWithParser:(id<BookParserDelegate>)parser cacher:(id<BookCacheDelegate>)cacher;

@end

NS_ASSUME_NONNULL_END
