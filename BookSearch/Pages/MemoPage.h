//
//  MemoPage.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/31.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemoPage : UIViewController

- (instancetype)initWith:(NSString*)isbn13;

@property (weak, nonatomic) IBOutlet UITextView *tvMemo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomTvMemo;

- (IBAction)closeClick:(id)sender;
- (IBAction)saveClick:(id)sender;

@end

NS_ASSUME_NONNULL_END
