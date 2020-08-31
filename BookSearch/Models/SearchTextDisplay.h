//
//  SearchMainDisplay.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/29.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SearchText;
@interface SearchTextDisplay : NSObject

@property (nonatomic, readonly, nullable) NSString *text;
@property (nonatomic, readonly, nullable) NSDate *date;

- (instancetype)initWithSearchText:(nonnull SearchText*)searchText;

@end

NS_ASSUME_NONNULL_END
