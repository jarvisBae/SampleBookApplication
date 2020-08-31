//
//  BookDetailSummayCell.h
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BookDetailDisplay;
@interface BookDetailSummayCell : UITableViewCell

- (void)setDisplay:(nullable BookDetailDisplay*)display;

@property (weak, nonatomic) IBOutlet UIImageView *ivImage;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *labelRating;
@property (weak, nonatomic) IBOutlet UILabel *labelPage;
@property (weak, nonatomic) IBOutlet UILabel *labelYear;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelLanguage;

@end

NS_ASSUME_NONNULL_END
