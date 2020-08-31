//
//  SearchResultCell.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/25.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BookDisplay;
@interface SearchResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

- (void)setDisplay:(nullable BookDisplay*)display setText:(NSString *)searchText;

@end

NS_ASSUME_NONNULL_END
