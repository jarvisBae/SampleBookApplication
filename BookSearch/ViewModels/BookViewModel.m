//
//  BookViewModel.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookDelegate.h"
#import "BookViewModel.h"
#import "ServerAPI.h"
#import "BookParser.h"
#import "BookCache.h"
#import "BookDisplay.h"
#import "NSCache+Instance.h"

@interface BookViewModel()

@property (nonatomic, strong) id<BookFetcherDelegate> fetcher;
@property (nonatomic, strong) NSMutableArray<BookDisplay *> *items;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation BookViewModel

#pragma mark - initialize
- (instancetype)init {
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc] init];
        self.fetcher = [[ServerAPI alloc] initWithParser:[[BookParser alloc] init] cacher:[[BookCache alloc] init]];
    }
    return self;
}

#pragma mark - Load Data
- (void)getBooksWithQuery:(NSString *)query page:(NSString *)page withSuccess:(void (^)(NSArray<BookDisplay *> * _Nonnull, NSInteger, NSInteger))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    
    __weak BookViewModel *weakSelf = self;
    [self.fetcher fetchBooksWithQuery:query page:page isMore:NO withSuccess:^(NSArray<Book *> * _Nonnull books, NSInteger total, NSInteger page) {    
        NSMutableArray * items = [[NSMutableArray alloc] init];
        for (Book *book in books) {
            [items addObject:[[BookDisplay alloc] initWithBook:book]];
        }
        [weakSelf setItems:items];
        
        //save cache
        BookCache *bookCache = [[BookCache alloc] initWithBooks:books total:total page:page];
        [NSCache.manager setObject:bookCache forKey:query];
        successCompletion(items, total, page);
    } error:errorCompletion];
}

- (void)getBooksLoadmoreWithQuery:(NSString *)query page:(NSString *)page withSuccess:(void (^)(NSArray<BookDisplay *> * _Nonnull, NSInteger, NSInteger))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    
    if (!self.isLoading) {
        self.isLoading = YES;
        __weak BookViewModel *weakSelf = self;
        [self.fetcher fetchBooksWithQuery:query page:page isMore:YES withSuccess:^(NSArray<Book *> * _Nonnull books, NSInteger total, NSInteger page) {
            NSMutableArray * items = [[NSMutableArray alloc] init];
            for (Book *book in books) {
                [items addObject:[[BookDisplay alloc] initWithBook:book]];
            }
            [weakSelf.items addObjectsFromArray:items];
            weakSelf.isLoading = NO;
            
            //save cache
            BookCache *bookCache = [[BookCache alloc] initWithBooks:[weakSelf.items copy] total:total page:page];
            [NSCache.manager setObject:bookCache forKey:query];
            successCompletion(items, total, page);
        } error:errorCompletion];
    }
}

- (NSUInteger)numberOfItems {
    return self.items.count;
}

- (NSUInteger)numberOfSections {
    return 1;
}

- (BookDisplay *)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.items.count) {
        return nil;
    }
    return self.items[indexPath.row];
}

#pragma mark - Delete Data
- (void)removeAll {
    [self.items removeAllObjects];
}

@end
