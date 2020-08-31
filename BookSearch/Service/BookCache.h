//
//  BookCache.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/30.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@class Book;
@interface BookCache : NSObject<BookCacheDelegate>

- (instancetype)initWithBooks:(NSArray<Book*>*)books total:(NSInteger)total page:(NSInteger)page;

@property (nonatomic, strong) NSArray<Book*> *books;
@property (nonatomic) NSInteger total;
@property (nonatomic) NSInteger page;

@end

NS_ASSUME_NONNULL_END
