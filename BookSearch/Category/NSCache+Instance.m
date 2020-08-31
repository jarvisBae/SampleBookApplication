//
//  NSCache+Instance.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/30.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "NSCache+Instance.h"

@implementation NSCache (Instance)

+ (instancetype)manager {
    static dispatch_once_t once;
    static NSCache *cache = nil;
    if (!cache) {
        dispatch_once(&once, ^{
            cache = [[NSCache alloc] init];
        });
    }
    return cache;
}

@end
