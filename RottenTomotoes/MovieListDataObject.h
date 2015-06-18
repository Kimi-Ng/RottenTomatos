//
//  MovieListDataObject.h
//  RottenTomotoes
//
//  Created by Cheng-Yuan Wu on 6/14/15.
//  Copyright (c) 2015 Kimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieListDataObject : NSObject
@property (strong, nonatomic) NSMutableArray *movieList;
@property NSInteger totalMovies;
+ (id)sharedInstance;
- (void)addData:(NSDictionary *)mvData;
- (void)reloadDataWithClean:(NSDictionary *)mvData;
@end
