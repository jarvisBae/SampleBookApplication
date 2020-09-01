//
//  BookDetailSummayCell.m
//  BookSearch
//
//  Created by JINKI BAE on 2020/08/27.
//  Copyright © 2020 JINKI BAE. All rights reserved.
//

#import "BookDetailSummayCell.h"
#import "BookDetailDisplay.h"
#import "NSCache+Instance.h"
#import "Functions.h"

@implementation BookDetailSummayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ivImage.layer.borderColor = UIColor.separatorColor.CGColor;
    self.ivImage.layer.borderWidth = 0.3;
}

#pragma mark - Set Data
- (void)setDisplay:(BookDetailDisplay *)display {
    
    [self.labelTitle setText:display.title];
    [self.labelSubtitle setText:display.subtitle];
    [self.labelRating setText:[[NSString alloc] initWithFormat:@"%.1lf", display.rating]];
    [self.labelPage setText:display.pages];
    [self.labelYear setText:display.year];
    [self.labelLanguage setText:display.language];
    
    
    self.ivImage.image = nil;
    [self.ivImage imageDownloadWith:display.image];
}

@end
