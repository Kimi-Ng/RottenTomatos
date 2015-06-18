//
//  MovieDetailVC.m
//  RottenTomotoes
//
//  Created by Cheng-Yuan Wu on 6/14/15.
//  Copyright (c) 2015 Kimi. All rights reserved.
//

#import "MovieDetailVC.h"
#import "MovieListDataObject.h"
#import "MovieDataObject.h"
#import <UIImageView+AFNetworking.h>
@interface MovieDetailVC ()
@property NSInteger index;
@end

@implementation MovieDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    MovieDataObject *object =[[MovieListDataObject sharedInstance] movieList][self.index];
    
    NSURL *url =[NSURL URLWithString:[self convertPosterUrlStringToHighRes:object.posterUrl]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.movieImage setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"placeHolder.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [self.movieImage setImage:image];
        self.connectionErrImg.hidden = YES;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        self.connectionErrImg.hidden = NO;
    }];
    
    self.movieDescription.text = object.synopsis;
    self.movieTitle.text =  object.title;
}

- (void)viewDidLayoutSubviews
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y  = self.view.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    [self.movieImage setFrame:viewFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData:(NSIndexPath*)indexPath {
    self.index = indexPath.row;
}

- (NSString *)convertPosterUrlStringToHighRes:(NSString *)urlString {
    NSRange range = [urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue = urlString;
    if (range.length > 0) {
        returnValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    return returnValue;
}

@end
