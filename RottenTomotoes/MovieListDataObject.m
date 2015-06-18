//
//  MovieListDataObject.m
//  RottenTomotoes
//
//  Created by Cheng-Yuan Wu on 6/14/15.
//  Copyright (c) 2015 Kimi. All rights reserved.
//

#import "MovieListDataObject.h"
#import "MovieDataObject.h"

@implementation MovieListDataObject

+ (id)sharedInstance {
        static MovieListDataObject *instance = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[self alloc] init];
        });
        
        return instance;
}

- (id)init {
    self = [super init];
    self.movieList = [[NSMutableArray alloc] init];
    return self;
}

- (void)addData:(NSDictionary *)mvData {
    self.totalMovies = [mvData[@"total"] integerValue] ;
    for (id mv in mvData[@"movies"]) {
        MovieDataObject *movie = [[MovieDataObject alloc] initWithData: mv[@"title"] synopsis:mv[@"synopsis"] posterUrl:mv[@"posters"][@"thumbnail"]];
                [self.movieList addObject:movie];
    }
}

- (void)reloadDataWithClean:(NSDictionary *)mvData {
    //clear origin data
    [self.movieList removeAllObjects];
    
    for (id mv in mvData[@"movies"]) {
        MovieDataObject *movie = [[MovieDataObject alloc] initWithData: mv[@"title"] synopsis:mv[@"synopsis"] posterUrl:mv[@"posters"][@"thumbnail"]];
        [self.movieList addObject:movie];
    }
}

@end
