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

@implementation BookDetailSummayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ivImage.layer.borderColor = UIColor.separatorColor.CGColor;
    self.ivImage.layer.borderWidth = 0.3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDisplay:(BookDetailDisplay *)display {
    
    [self.labelTitle setText:display.title];
    [self.labelSubtitle setText:display.subtitle];
    [self.labelRating setText:[[NSString alloc] initWithFormat:@"%.1lf", display.rating]];
    [self.labelPage setText:display.pages];
    [self.labelYear setText:display.year];
    [self.labelLanguage setText:display.language];
    
    
    self.ivImage.image = nil;
    UIImage *cacheImage = [NSCache.manager objectForKey:display.image];
    if (cacheImage != nil) {
        self.ivImage.image = cacheImage;
    } else {
        __weak BookDetailSummayCell *weakSelf = self;
        NSURL *url = [NSURL URLWithString:display.image];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [NSCache.manager setObject:image forKey:display.image];
                        weakSelf.ivImage.image = image;
                    });
                }
            }
        }];
        [task resume];
    }
}

@end
