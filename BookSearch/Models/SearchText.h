//
//  SearchText.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/29.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchText : NSObject<NSSecureCoding>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *date;

- (instancetype)initWithSearchText:(NSString*)text date:(NSDate*)date;

@end

NS_ASSUME_NONNULL_END
