//
//  BookFetcherDelegate.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Book, BookDetail;

typedef void(^SuccessCompletionHandler)(NSArray<Book *> *books, NSInteger total, NSInteger page);
typedef void(^ErrorCompletionHandler)(NSError * _Nullable error);

@protocol BookFetcherDelegate <NSObject>

@optional
- (void)fetchBooksWithQuery:(NSString *)query
                       page:(NSString*)page
                withSuccess:(SuccessCompletionHandler)successCompletion
                      error:(ErrorCompletionHandler)errorCompletion;

- (void)fetchBooksWithQuery:(NSString *)query
                       page:(NSString*)page
                     isMore:(BOOL)isMore
                withSuccess:(SuccessCompletionHandler)successCompletion
                      error:(ErrorCompletionHandler)errorCompletion;


@optional
- (void)fetchBooksWithBookId:(NSString *)isbn13
                 withSuccess:(void (^)(BookDetail *bookDetail))successCompletion
                       error:(ErrorCompletionHandler)errorCompletion;

@end

@protocol BookParserDelegate <NSObject>

@optional
- (void)parseBooks:(NSData *)data withSuccess:(SuccessCompletionHandler)successCompletion error:(void (^)(NSError *error))errorCompletion;

@optional
- (void)parseBookDetail:(NSData *)data withSuccess:(void (^)(BookDetail *))successCompletion error:(void (^)(NSError *error))errorCompletion;

@end

@protocol BookCacheDelegate <NSObject>

@optional
- (void)fetchBooksCacheWithQuery:(NSString *)query success:(void(^)(NSArray<Book *> *books, NSInteger total, NSInteger page))successCompletion error:(void(^)(NSError * _Nullable error))errorCompletion;

@end

NS_ASSUME_NONNULL_END
