//
//  MovieDataObject.h
//  RottenTomotoes
//
//  Created by Cheng-Yuan Wu on 6/14/15.
//  Copyright (c) 2015 Kimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDataObject : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *synopsis;
@property (strong, nonatomic) NSString *posterUrl;
- (id) initWithData:(NSString *)title synopsis:(NSString *)synopsis posterUrl:(NSString *)posterUrl;
@end
