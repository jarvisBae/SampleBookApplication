//
//  BookDetailDescCell.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BookDetailDisplay;
@interface BookDetailDescCell : UITableViewCell

- (void)setDisplay:(nullable BookDetailDisplay*)display;

@property (weak, nonatomic) IBOutlet UILabel *labelDesc;
@property (weak, nonatomic) IBOutlet UILabel *labelPublisher;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthors;
@property (weak, nonatomic) IBOutlet UIButton *buttonUrlLink;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote;

- (IBAction)urlLinkClick:(id)sender;
- (IBAction)noteClick:(id)sender;

@property (copy, nonatomic) void (^didTapButtonBlock)(id sender);
- (void)setDidTapButtonBlock:(void (^)(id sender))didTapButtonBlock;


@end

NS_ASSUME_NONNULL_END
