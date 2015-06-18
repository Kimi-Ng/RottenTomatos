//
//  RottenTomatoDataModel.m
//  RottenTomotoes
//
//  Created by Cheng-Yuan Wu on 6/14/15.
//  Copyright (c) 2015 Kimi. All rights reserved.
//

#import "RottenTomatoDataModel.h"
#import "MovieDataObject.h"
#import "MovieListDataObject.h"
#import "MovieListTVC.h"
/**
 * Responsibility of data model:
 *   1) send api request and get Json response
 *   2) parse the response Json data to data object
 */

@implementation RottenTomatoDataModel

/*
 //api.rottentomatoes.com/api/public/v1.0/lists/dvds.json
 "top_rentals":"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json","current_releases":"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/current_releases.json","new_releases":"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json","upcoming":"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/upcoming.json"}
 //api.rottentomatoes.com/api/public/v1.0/movies.json?
 
 
 dvdApiUrl = api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us
 */

- (void)loadData:(NSUInteger)pageNumber completionCallBackBlock:(void(^)(NSDictionary *))completionCallBackBlock {

    loadingState = Loading;
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&page_limit=20&page=%d";
    urlString = [NSString stringWithFormat:urlString, pageNumber];
    NSURL *apiUrl = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:apiUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        NSDictionary *mvData;
        if (connectionError) {
            loadingState = LoadingErr;
        }
        else {
            mvData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"data model length = %ld", [mvData[@"movies"] count]);
            
            //stilll loading data
            NSLog(@"stilll loading data.........");
            loadingMask.hidden = NO;
            loadingState = LoadingDone;
        }
        completionCallBackBlock(mvData);
        //tell the caller that this function is completed with the data!
    }];
}



@end
