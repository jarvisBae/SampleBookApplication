//
//  BookDetailViewModel.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookDelegate.h"
#import "BookDetailViewModel.h"
#import "ServerAPI.h"
#import "BookParser.h"
#import "BookDetailDisplay.h"

@interface BookDetailViewModel()

@property (nonatomic, strong) id<BookFetcherDelegate> fetcher;
@property (nonatomic, strong) BookDetailDisplay *bookDetail;

@end

@implementation BookDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fetcher = [[ServerAPI alloc] initWithParser:[[BookParser alloc] init]];
    }
    return self;
}

- (void)getBookDetailWithBookId:(NSString *)isbn13 withSuccess:(void (^)(BookDetailDisplay * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    __weak BookDetailViewModel *weakSelf = self;
    [self.fetcher fetchBooksWithBookId:isbn13 withSuccess:^(BookDetail * _Nonnull bookDetail) {
        weakSelf.bookDetail = [[BookDetailDisplay alloc] initWithBookDetail:bookDetail];
        successCompletion(weakSelf.bookDetail);
    } error:errorCompletion];
}

- (NSUInteger)numberOfItems {
    return (self.bookDetail == nil) ? 0 : 2;
}

- (NSUInteger)numberOfSections {
    return 1;
}

- (BookDetailDisplay *)item {
    return (self.bookDetail == nil) ? nil : self.bookDetail;
}

@end
