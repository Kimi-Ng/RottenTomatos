//
//  RottenTomatoDataModel.h
//  RottenTomotoes
//
//  Created by Cheng-Yuan Wu on 6/14/15.
//  Copyright (c) 2015 Kimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RottenTomatoDataModel : NSObject

//- (void)loadData;
- (void)loadData:(NSUInteger)pageNumber completionCallBackBlock:(void(^)(NSDictionary *))completionCallBackBlock;
@end
