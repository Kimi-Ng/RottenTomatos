//
//  MovieDataObject.m
//  RottenTomotoes
//
//  Created by Cheng-Yuan Wu on 6/14/15.
//  Copyright (c) 2015 Kimi. All rights reserved.
//

#import "MovieDataObject.h"

@implementation MovieDataObject

- (id) initWithData:(NSString *)title synopsis:(NSString *)synopsis posterUrl:(NSString *)posterUrl {
    self = [super init];
    if (self) {
        self.title = title;
        self.synopsis = synopsis;
        self.posterUrl = posterUrl;
    }
    return self;
}

@end
