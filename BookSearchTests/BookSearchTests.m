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

- (void)testGetBooks {
    BookViewModel *bookViewModel = [[BookViewModel alloc] init];
    
    __block NSArray<BookDisplay *> *resultBooksFirst = nil;
    __block NSArray<BookDisplay *> *resultBooksSecond = nil;
    
    [bookViewModel getBooksWithQuery:@"book" page:@"1" success:^(NSArray<BookDisplay *> * _Nonnull books, NSInteger total, NSInteger page) {
        resultBooksFirst = books;
    } error:^(NSError * _Nonnull error) {

    }];
    
    [bookViewModel getBooksWithQuery:@"book" page:@"2" success:^(NSArray<BookDisplay *> * _Nonnull books, NSInteger total, NSInteger page) {
        resultBooksSecond = books;
    } error:^(NSError * _Nonnull error) {

    }];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"APIPrivoderTaskExpectation"];
    XCTWaiter *waiter = [[XCTWaiter alloc] init];
    [waiter waitForExpectations:@[expectation] timeout:5.0];
    
    XCTAssertEqualObjects(resultBooksFirst, resultBooksFirst);
    XCTAssertEqualObjects(resultBooksSecond, resultBooksSecond);
}

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

    XCTAssertEqualObjects(bookDetailDisplayFirst, bookDetailDisplayFirst);
    XCTAssertEqualObjects(bookDetailDisplaySecond.isbn13.description, isbn13.description);
}

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

- (void)testFunctions {
    
    NSString *saveData = @"hello";
    NSString *saveDataKey = @"hello_key";
    
    [Functions saveDataToPlist:saveData forKey:saveDataKey];
    
    NSString *savedData = [Functions loadDataFromPlistForKey:saveDataKey];
    
    XCTAssertEqualObjects(saveData, savedData);
}

@end
