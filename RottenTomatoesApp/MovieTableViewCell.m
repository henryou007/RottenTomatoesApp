//
//  MovieTableViewCell.m
//  RottenTomatoesApp
//
//  Created by Jin You on 10/18/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor darkGrayColor];
    self.selectedBackgroundView =  selectedView;
    self.movieTitleLabel.highlightedTextColor = [UIColor yellowColor];
    self.movieSynopsisLabel.highlightedTextColor = [UIColor yellowColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.textLabel.textColor = [UIColor yellowColor];
    } else {
        self.textLabel.textColor = [UIColor yellowColor];
    }
}

@end
