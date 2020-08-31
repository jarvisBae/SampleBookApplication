//
//  BookParser.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookParser.h"
#import "Book.h"
#import "BookDetail.h"

@implementation BookParser

#pragma mark - Parse
- (void)parseBooks:(NSData *)data withSuccess:(void (^)(NSArray<Book *> * _Nonnull, NSInteger, NSInteger))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    NSError *error;
    NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (!jsonDictionary || error) {
        errorCompletion(error);
        return;
    }
    NSInteger total = [[jsonDictionary objectForKey:@"total"] integerValue];
    NSInteger page = [[jsonDictionary objectForKey:@"page"] integerValue];
    
    NSArray *jsonArray = [jsonDictionary objectForKey:@"books"];
    if (!jsonArray) {
        NSError * error = [NSError errorWithDomain:NSCocoaErrorDomain code:999 userInfo:nil];
        errorCompletion(error);
        return;
    }
    
    NSMutableArray<Book *> *result = [[NSMutableArray alloc] init];
    for (NSDictionary *item in jsonArray) {
        
        NSString *title     = [item objectForKey:@"title"];
        NSString *subtitle  = [item objectForKey:@"subtitle"];
        NSString *isbn13    = [item objectForKey:@"isbn13"];
        NSString *price     = [item objectForKey:@"price"];
        NSString *image     = [item objectForKey:@"image"];
        NSString *url       = [item objectForKey:@"url"];
        
        Book * book = [[Book alloc] initWithTitle:title subtitle:subtitle isbn13:isbn13 price:price image:image url:url];
        [result addObject:book];
    }
    
    successCompletion(result, total, page);
}

- (void)parseBookDetail:(NSData *)data withSuccess:(void (^)(BookDetail * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    NSError *error;
    NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    @try {
        BOOL _error = (BOOL)[[jsonDictionary objectForKey:@"error"] integerValue];
        NSString *title = [jsonDictionary objectForKey:@"title"];
        NSString *subtitle = [jsonDictionary objectForKey:@"subtitle"];
        NSString *authors = [jsonDictionary objectForKey:@"authors"];
        NSString *publisher = [jsonDictionary objectForKey:@"publisher"];
        NSString *language = [jsonDictionary objectForKey:@"language"];
        NSString *isbn10 = [jsonDictionary objectForKey:@"isbn10"];
        NSString *isbn13 = [jsonDictionary objectForKey:@"isbn13"];
        NSString *pages = [jsonDictionary objectForKey:@"pages"];
        NSString *year = [jsonDictionary objectForKey:@"year"];
        float rating = [[jsonDictionary objectForKey:@"rating"] floatValue];
        NSString *desc = [jsonDictionary objectForKey:@"desc"];
        NSString *price = [jsonDictionary objectForKey:@"price"];
        NSString *image = [jsonDictionary objectForKey:@"image"];
        NSString *url = [jsonDictionary objectForKey:@"url"];
        
        BookDetail *bookDetail = [[BookDetail alloc] initWithTitle:title subtitle:subtitle authors:authors publisher:publisher language:language isbn10:isbn10 isbn13:isbn13 pages:pages year:year rating:rating desc:desc price:price image:image url:url error:_error];
        successCompletion(bookDetail);
    } @catch (NSException *exception){
        errorCompletion(error);
    }
}



@end
