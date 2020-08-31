//
//  SearchResultBookCell.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/26.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BookDisplay;
@interface SearchResultBookCell : UITableViewCell

- (void)setDisplay:(nullable BookDisplay*)display;
- (void)setDisplay:(nullable BookDisplay*)display tableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;

@property (weak, nonatomic) IBOutlet UIImageView *ivBook;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelIsbn13;
@property (weak, nonatomic) IBOutlet UIButton *buttonUrlLink;

- (IBAction)urlLinkClick:(id)sender;

@end

NS_ASSUME_NONNULL_END
