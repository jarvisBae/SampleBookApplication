//
//  BookCache.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/30.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "BookCache.h"
#import "NSCache+Instance.h"

@implementation BookCache

- (instancetype)initWithBooks:(NSArray<Book *> *)books total:(NSInteger)total page:(NSInteger)page {
    self = [super init];
    if (self) {
        self.books = books;
        self.total = total;
        self.page = page;
    }
    return self;
}

- (void)fetchBooksCacheWithQuery:(NSString *)query success:(void (^)(NSArray<Book *> * _Nonnull, NSInteger, NSInteger))successCompletion error:(void (^)(NSError * _Nullable))errorCompletion {
    BookCache *bookCache = [NSCache.manager objectForKey:query];
    if (bookCache != nil) {
        successCompletion(bookCache.books, bookCache.total, bookCache.page);
    } else {
        NSError *error;
        errorCompletion(error);
    }
}

@end
