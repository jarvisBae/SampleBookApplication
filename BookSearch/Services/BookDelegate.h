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

/**
 * 공통 성공 핸들러 블럭
 * @Param books 도서정보 리스트
 * @Param total 입력한 키워드의 총 검색결과 갯수, loadmore 더이상 하지 않는 경우사용
 * @param page 현재 페이지 수, loadmore시 사용
*/
typedef void(^SuccessCompletionHandler)(NSArray<Book *> *books, NSInteger total, NSInteger page);
/**
 * 공통 실패 핸들러 블럭
 * @Param error 에러사항
*/
typedef void(^ErrorCompletionHandler)(NSError * _Nullable error);

@protocol BookFetcherDelegate <NSObject>

/**
 * 도서 리스트 정보 호출, 최초 호출시에 캐쉬된 데이터가 있는지 확인하기 위해 사용
 * @param query 검색어
 * @param page 페이지수 ++로 증가
 * @param successCompletion 성공 핸들러 블럭
 * @Param errorCompletion 실패 핸들러 블럭
*/
@optional
- (void)fetchBooksWithQuery:(NSString *)query
                       page:(NSString*)page
                success:(SuccessCompletionHandler)successCompletion
                      error:(ErrorCompletionHandler)errorCompletion;
/**
 * 도서 리스트 정보 호출
 * @param query 검색어
 * @param page 페이지수 ++로 증가
 * @param isMore 더보기의 경우처리
 * @param successCompletion 성공 핸들러 블럭
 * @Param errorCompletion 실패 핸들러 블럭
*/
- (void)fetchBooksWithQuery:(NSString *)query
                       page:(NSString*)page
                     isMore:(BOOL)isMore
                success:(SuccessCompletionHandler)successCompletion
                      error:(ErrorCompletionHandler)errorCompletion;

/**
 * 도서 상세정보 호출
 * @param isbn13 북ID
 * @param successCompletion 성공 핸들러 블럭
 * @Param errorCompletion 실패 핸들러 블럭
*/
@optional
- (void)fetchBooksWithBookId:(NSString *)isbn13
                 success:(void (^)(BookDetail *bookDetail))successCompletion
                       error:(ErrorCompletionHandler)errorCompletion;

@end

@protocol BookParserDelegate <NSObject>

/**
 * 도서 리스트 정보 파서
 * @param data 도서정보 data
 * @param successCompletion 성공 핸들러 블럭
 * @Param errorCompletion 실패 핸들러 블럭
*/
@optional
- (void)parseBooks:(NSData *)data success:(SuccessCompletionHandler)successCompletion error:(void (^)(NSError *error))errorCompletion;

/**
 * 도서 상세정보 파서
 * @param data 도서정보 data
 * @param successCompletion 성공 핸들러 블럭
 * @Param errorCompletion 실패 핸들러 블럭
*/
@optional
- (void)parseBookDetail:(NSData *)data success:(void (^)(BookDetail *))successCompletion error:(void (^)(NSError *error))errorCompletion;

@end

@protocol BookCacheDelegate <NSObject>

/**
 * 캐쉬에 저장된 정보 호출
 * @param query 검색어
 * @param successCompletion 성공 핸들러 블럭
 * @Param errorCompletion 실패 핸들러 블럭
*/

@optional
- (void)fetchBooksCacheWithQuery:(NSString *)query success:(void(^)(NSArray<Book *> *books, NSInteger total, NSInteger page))successCompletion error:(void(^)(NSError * _Nullable error))errorCompletion;

@end

NS_ASSUME_NONNULL_END
