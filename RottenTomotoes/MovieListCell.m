//
//  MovieListCell.m
//  RottenTomotoes
//
//  Created by Cheng-Yuan Wu on 6/14/15.
//  Copyright (c) 2015 Kimi. All rights reserved.
//

#import "MovieListCell.h"

@implementation MovieListCell

- (void)awakeFromNib {
    // Initialization code
    //self.movieDescription.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.movieImage.image = nil; // set your placeholder image
}

@end
