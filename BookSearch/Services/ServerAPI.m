//
//  ServerAPI.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "ServerAPI.h"

@interface ServerAPI()

@property (nonatomic, strong) id<BookParserDelegate> parser;
@property (nonatomic, strong) id<BookCacheDelegate> cacher;

@end

@implementation ServerAPI

#pragma mark - initialize
+ (instancetype)manager {
    static dispatch_once_t once;
    static ServerAPI *__sharedInstance = nil;
    if (!__sharedInstance) {
        // @synchronized([ServerAPI class]) {
        // : 메소드에 synchronized를 걸 수 있는 것이 아니므로, 다른 언어와 다르게 DCL(Double-checked locking)이 등장하지는 않음
        //   @synchronized 대신 앱의 생명주기에 블럭객체를 단 한번 생성을 보장하는 dispatch_once 사용
        dispatch_once(&once, ^{
            // __sharedInstance = [[ServerAPI alloc] init];
            // : 위처럼 할 경우 서브클래싱 시 서브클래싱된 인스턴스가 아니라 Functions 인스턴스가 생성
            __sharedInstance = [[[self class] alloc] init];
        });
    }
    return __sharedInstance;
}

- (instancetype)initWithParser:(id<BookParserDelegate>)parser {
    self = [super init];
    if (self) {
        self.parser = parser;
    }
    return self;
}

- (instancetype)initWithParser:(id<BookParserDelegate>)parser cacher:(id<BookCacheDelegate>)cacher {
    self = [super init];
    if (self) {
        self.parser = parser;
        self.cacher = cacher;
    }
    return self;
}

# pragma mark - BookFetcherDelegate implementation
- (void)fetchBooksWithBookId:(NSString *)isbn13 success:(void (^)(BookDetail * _Nonnull))successCompletion  error:(ErrorCompletionHandler)errorCompletion {
        NSString *url = [BOOK_DETAIL_BASE stringByAppendingString:isbn13];
        __weak ServerAPI * weakSelf = self;
        [self GET:url parameters:nil success:^(NSData * _Nonnull data, id  _Nullable responseObject) {
            [weakSelf.parser parseBookDetail:data success:successCompletion error:errorCompletion];
        } failure:^(NSData * _Nullable data, NSError * _Nonnull error) {
            [weakSelf.parser parseBookDetail:data success:successCompletion error:errorCompletion];
        }];
}


- (void)fetchBooksWithQuery:(NSString *)query page:(NSString *)page isMore:(BOOL)isMore success:(SuccessCompletionHandler)successCompletion error:(ErrorCompletionHandler)errorCompletion {
    if (!isMore) {
        [self.cacher fetchBooksCacheWithQuery:query success:^(NSArray<Book *> * _Nonnull books, NSInteger total, NSInteger page) {
            successCompletion(books, total, page);
        } error:^(NSError * _Nullable error) {
            [self fetchBooksWithQuery:query page:page success:successCompletion error:errorCompletion];
        }];
    } else {
        [self fetchBooksWithQuery:query page:page success:successCompletion error:errorCompletion];
    }
}

- (void)fetchBooksWithQuery:(NSString *)query page:(NSString *)_page success:(SuccessCompletionHandler)successCompletion error:(ErrorCompletionHandler)errorCompletion {
    NSString *escapedQuery = [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *url = [[SEARCH_LIST_BASE stringByAppendingString:escapedQuery] stringByAppendingFormat:@"/%@", _page];
    
    __weak ServerAPI * weakSelf = self;
    [self GET:url parameters:nil success:^(NSData * _Nonnull data, id  _Nullable responseObject) {
        [weakSelf.parser parseBooks:data success:successCompletion error:errorCompletion];
    } failure:^(NSData * _Nullable data, NSError * _Nonnull error) {
        [weakSelf.parser parseBooks:data success:successCompletion error:errorCompletion];
    }];
}

# pragma mark - private methods
- (void) GET:(NSString *)url
  parameters:(id)parameters
     success:(void (^)(NSData * _Nonnull, id _Nullable))success
     failure:(void (^)(NSData * _Nullable, NSError * _Nonnull))failure  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"GET"];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (data!=nil) {
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                success(data, json);
            } else {
                failure(data, error);
            }
        }] resume];
    });
}

@end

