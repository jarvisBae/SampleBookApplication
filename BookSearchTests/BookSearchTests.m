//
//  BookSearchTests.m
//  BookSearchTests
//
//  Created by JINKI BAE on 2020/09/01.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BookViewModel.h"
#import "BookDetailViewModel.h"
#import "SearchTextViewModel.h"
#import "Functions.h"
#import "NSCache+Instance.h"
#import "BookCache.h"
#import "BookDisplay.h"

@interface BookSearchTests : XCTestCase

@end

@implementation BookSearchTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

/**
 * books api 테스트 : 각각 동일한 검색어를 입력한 경우에 결과가 동일여부 테스트
 */
- (void)testGetBooks {
    BookViewModel *bookViewModel = [[BookViewModel alloc] init];
    
    NSString *query = @"book";
    __block NSArray<BookDisplay *> *resultBooksFirst = nil;
    __block NSArray<BookDisplay *> *resultBooksSecond = nil;
    
    [bookViewModel getBooksWithQuery:query page:@"1" success:^(NSArray<BookDisplay *> * _Nonnull books, NSInteger total, NSInteger page) {
        resultBooksFirst = books;
    } error:^(NSError * _Nonnull error) {

    }];
    
    [bookViewModel getBooksWithQuery:query page:@"1" success:^(NSArray<BookDisplay *> * _Nonnull books, NSInteger total, NSInteger page) {
        resultBooksSecond = books;
    } error:^(NSError * _Nonnull error) {

    }];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"APIPrivoderTaskExpectation"];
    XCTWaiter *waiter = [[XCTWaiter alloc] init];
    [waiter waitForExpectations:@[expectation] timeout:5.0];
    
    XCTAssertEqual(resultBooksFirst.count, resultBooksSecond.count);
    
    for (int i=0; i<resultBooksFirst.count; i++) {
        BookDisplay *bookDisplayFirst = [resultBooksFirst objectAtIndex:i];
        BookDisplay *bookDisplaySecond = [resultBooksSecond objectAtIndex:i];
        
        XCTAssertEqualObjects(bookDisplayFirst.title, bookDisplaySecond.title);
        XCTAssertEqualObjects(bookDisplayFirst.subtitle, bookDisplaySecond.subtitle);
        XCTAssertEqualObjects(bookDisplayFirst.isbn13, bookDisplaySecond.isbn13);
    }
}
/**
 * book detail api 테스트 : 각각 동일한 검색어를 입력한 경우에 결과가 동일여부 테스트
*/
- (void)testGetBookDetail {
    NSString *isbn13 = @"9780596806606";
    
    BookDetailViewModel *bookDetailViewModelFirst = [[BookDetailViewModel alloc] init];
    BookDetailViewModel *bookDetailViewModelSecond = [[BookDetailViewModel alloc] init];
    __block BookDetailDisplay *bookDetailDisplayFirst;
    __block BookDetailDisplay *bookDetailDisplaySecond;
    
    
    [bookDetailViewModelFirst getBookDetailWithBookId:isbn13 success:^(BookDetailDisplay * _Nonnull bookDetail) {
        bookDetailDisplayFirst = bookDetail;
    } error:^(NSError * _Nonnull error) {
        
    }];
    
    [bookDetailViewModelSecond getBookDetailWithBookId:isbn13 success:^(BookDetailDisplay * _Nonnull bookDetail) {
        bookDetailDisplaySecond = bookDetail;
    } error:^(NSError * _Nonnull error) {
        
    }];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"APIPrivoderTaskExpectation"];
    XCTWaiter *waiter = [[XCTWaiter alloc] init];
    [waiter waitForExpectations:@[expectation] timeout:5.0];

    XCTAssertEqualObjects(bookDetailDisplayFirst.isbn13, isbn13);
    XCTAssertEqualObjects(bookDetailDisplaySecond.isbn13, isbn13);
}

/**
 * 사용자가 검색어를 입력한 경우에 저장 여부 테스트
*/
- (void)testLocalCacheSaveAndLoad {
    
    NSString *inputText = @"Hello!!!";
    __block NSArray<SearchTextDisplay*> *arr;
    
    SearchTextViewModel *searchTextViewModel = [[SearchTextViewModel alloc] init];
    [searchTextViewModel saveSearchTextWithText:inputText success:^(NSArray<SearchTextDisplay *> * _Nonnull searchTexts) {
        arr = searchTexts;
    } error:^(NSError * _Nonnull error) {
        
    }];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"APIPrivoderTaskExpectation"];
    XCTWaiter *waiter = [[XCTWaiter alloc] init];
    [waiter waitForExpectations:@[expectation] timeout:5.0];
    
    XCTAssertEqualObjects(inputText, [arr firstObject].text);
}
/**
 * 사용자가 검색어를 입력한 경우에 저장 여부 테스트
*/
- (void)testFunctions {
    
    NSString *saveData = @"hello";
    NSString *saveDataKey = @"hello_key";
    
    [Functions saveDataToPlist:saveData forKey:saveDataKey];
    
    NSString *savedData = [Functions loadDataFromPlistForKey:saveDataKey];
    
    XCTAssertEqualObjects(saveData, savedData);
}

/**
 *  books api호출 후 결과 정보가 nscache 저장 여부 테스트
*/
- (void)testGetBooksAndCacheCompare {
    
    NSString *query = @"book";
    BookViewModel *bookViewModel = [[BookViewModel alloc] init];
    __block NSArray<BookDisplay *> *resultBooksFirst = nil;
    __block NSMutableArray * items = [[NSMutableArray alloc] init];
    
    [bookViewModel getBooksWithQuery:query page:@"1" success:^(NSArray<BookDisplay *> * _Nonnull books, NSInteger total, NSInteger page) {
        resultBooksFirst = books;
        
        BookCache *bookCache = [NSCache.manager objectForKey:query];
        for (Book *book in bookCache.books) {
            [items addObject:[[BookDisplay alloc] initWithBook:book]];
        }
    } error:^(NSError * _Nonnull error) {

    }];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"APIPrivoderTaskExpectation"];
    XCTWaiter *waiter = [[XCTWaiter alloc] init];
    [waiter waitForExpectations:@[expectation] timeout:5.0];
    
    XCTAssertEqual(resultBooksFirst.count, items.count);

    for (int i=0; i<items.count; i++) {
        BookDisplay *bookDisplayForServer = [resultBooksFirst objectAtIndex:i];
        BookDisplay *bookDisplayForCache = [items objectAtIndex:i];
        
        XCTAssertEqual(bookDisplayForServer.title, bookDisplayForCache.title);
        XCTAssertEqual(bookDisplayForServer.subtitle, bookDisplayForCache.subtitle);
        XCTAssertEqual(bookDisplayForServer.isbn13, bookDisplayForCache.isbn13);
    }
    
    
    
    
}

@end
