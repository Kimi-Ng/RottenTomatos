//
//  MovieListTVC.h
//  RottenTomotoes
//
//  Created by Cheng-Yuan Wu on 6/14/15.
//  Copyright (c) 2015 Kimi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LoadingState) {
Loading = 0,
LoadingDone,
LoadingErr,
};

@interface MovieListTVC : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *connectionErrImg;
extern NSString *test;
extern LoadingState loadingState;
extern UIView *loadingMask;

@end
