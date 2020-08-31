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


+ (instancetype)manager {
    static dispatch_once_t once;
    static ServerAPI *__sharedInstance = nil;
    if (!__sharedInstance)
    {
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

# pragma mark -
# pragma mark BookFetcherDelegate implementation


- (void)fetchBooksWithBookId:(NSString *)isbn13 withSuccess:(void (^)(BookDetail * _Nonnull))successCompletion  error:(ErrorCompletionHandler)errorCompletion {
        NSString *url = [BOOK_DETAIL_BASE stringByAppendingString:isbn13];
        __weak ServerAPI * weakSelf = self;
        [self GET:url parameters:nil success:^(NSData * _Nonnull data, id  _Nullable responseObject) {
            [weakSelf.parser parseBookDetail:data withSuccess:successCompletion error:errorCompletion];
        } failure:^(NSData * _Nullable data, NSError * _Nonnull error) {
            [weakSelf.parser parseBookDetail:data withSuccess:successCompletion error:errorCompletion];
        }];
}


- (void)fetchBooksWithQuery:(NSString *)query page:(NSString *)page isMore:(BOOL)isMore withSuccess:(SuccessCompletionHandler)successCompletion error:(ErrorCompletionHandler)errorCompletion {
    if (!isMore) {
        [self.cacher fetchBooksCacheWithQuery:query success:^(NSArray<Book *> * _Nonnull books, NSInteger total, NSInteger page) {
            NSLog(@"fetchBooksCacheWithQuery result in : %d", books.count);
            successCompletion(books, total, page);
        } error:^(NSError * _Nullable error) {
            [self fetchBooksWithQuery:query page:page withSuccess:successCompletion error:errorCompletion];
        }];
    } else {
        [self fetchBooksWithQuery:query page:page withSuccess:successCompletion error:errorCompletion];
    }
}

- (void)fetchBooksWithQuery:(NSString *)query page:(NSString *)_page withSuccess:(SuccessCompletionHandler)successCompletion error:(ErrorCompletionHandler)errorCompletion {
    NSString *escapedQuery = [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *url = [[SEARCH_LIST_BASE stringByAppendingString:escapedQuery] stringByAppendingFormat:@"/%@", _page];
    
    __weak ServerAPI * weakSelf = self;
    [self GET:url parameters:nil success:^(NSData * _Nonnull data, id  _Nullable responseObject) {
        [weakSelf.parser parseBooks:data withSuccess:successCompletion error:errorCompletion];
    } failure:^(NSData * _Nullable data, NSError * _Nonnull error) {
        [weakSelf.parser parseBooks:data withSuccess:successCompletion error:errorCompletion];
    }];
}

# pragma mark -
# pragma mark private methods

- (void) GET:(NSString *)url
  parameters:(id)parameters
     success:(void (^)(NSData * _Nonnull, id _Nullable))success
     failure:(void (^)(NSData * _Nullable, NSError * _Nonnull))failure  {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data!=nil) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//            NSLog(@"json : %@", json.description);
            success(data, json);
        } else {
            failure(data, error);
        }
    }] resume];
    
}

@end

