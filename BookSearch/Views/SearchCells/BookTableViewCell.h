//
//  BookTableViewCell.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/24.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BookDisplay, SearchTextDisplay;
@interface BookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

- (void)setDisplayWithBook:(nullable BookDisplay *)display;
- (void)setDisplayWithSearchText:(nullable SearchTextDisplay *)display;

@end

NS_ASSUME_NONNULL_END
