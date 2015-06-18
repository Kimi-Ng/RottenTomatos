//
//  MovieListTVC.m
//  RottenTomotoes
//
//  Created by Cheng-Yuan Wu on 6/14/15.
//  Copyright (c) 2015 Kimi. All rights reserved.
//

#import "MovieListTVC.h"
#import "RottenTomatoDataModel.h"
//import data model
#import "MovieListDataObject.h"
#import "MovieListCell.h"
#import "MovieDataObject.h"
#import <UIImageView+AFNetworking.h>
#import "MovieDetailVC.h"


LoadingState loadingState;
UIView *loadingMask;
@interface MovieListTVC () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *movieTableView;
@property NSUInteger curPage;
@property RottenTomatoDataModel *dataModel;
@end

@implementation MovieListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *loadingLabel = [[UILabel alloc] init];
    
    //setup connection err imageView
    self.connectionErrImg.frame = CGRectMake(0, 0, self.view.frame.size.width, 40.0f);
    self.connectionErrImg.hidden = YES;
    //setup loading mask view
    loadingLabel.text = @"Loading ...";
    loadingLabel.font = [loadingLabel.font fontWithSize:48.0f];
    [loadingLabel setTextColor: [UIColor redColor]];
    [loadingLabel sizeToFit];
    loadingMask = [[UIView alloc] initWithFrame:self.view.frame];
    
    [loadingMask addSubview:loadingLabel];
    loadingLabel.frame = CGRectMake((self.view.frame.size.width - loadingLabel.frame.size.width)/2, (self.view.frame.size.height - loadingLabel.frame.size.height)/2, loadingLabel.frame.size.width, loadingLabel.frame.size.height);

    [loadingMask setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7f]];
    [self.view addSubview:loadingMask];
    //Define your class for the cell
    //[self.movieTableView registerClass:[MovieListCell class] forCellReuseIdentifier:@"MovieListCell"];
    self.curPage = 1;

    //Define your custom cell with new file and xib
    [self.movieTableView registerNib:[UINib nibWithNibName:@"MovieListCell" bundle:nil] forCellReuseIdentifier:@"MovieListCell"];
    self.movieTableView.dataSource = self;
    self.movieTableView.delegate = self;

    self.dataModel = [[RottenTomatoDataModel alloc] init];

    [self.dataModel loadData:self.curPage completionCallBackBlock:^(NSDictionary *mvData) {
        //data done
        if (loadingState == LoadingDone) {
            loadingMask.hidden = YES;
        }
        else if(loadingState == LoadingErr){
            loadingMask.hidden = YES;
            self.connectionErrImg.hidden = NO;
            //show err
            
        }
        else {
            self.connectionErrImg.hidden = YES;
            loadingMask.hidden = NO;
        }

        [[MovieListDataObject sharedInstance] addData:mvData];
        [self.movieTableView reloadData];
    }];
    
    
    UIRefreshControl *pullToRefreshControl = [[UIRefreshControl alloc] init];
    [pullToRefreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    pullToRefreshControl.tintColor =  [UIColor magentaColor];

    self.refreshControl = pullToRefreshControl;

    //initial data model
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[MovieListDataObject sharedInstance] movieList] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieListCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[MovieListCell alloc] init];
    }
    
    if ([[[MovieListDataObject sharedInstance] movieList]count] > 0) {
        MovieDataObject *object =[[MovieListDataObject sharedInstance] movieList][indexPath.row];
        cell.movieTitle.text = object.title;
        cell.movieDescription.numberOfLines = 0;
        [cell.movieDescription sizeToFit];
        cell.movieDescription.text = object.synopsis;
        [cell.movieImage setImageWithURL:[NSURL URLWithString:[self convertPosterUrlStringToHighRes:object.posterUrl]]];

    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    MovieDetailVC *controller = [[MovieDetailVC alloc] initWithNibName:@"MovieDetailVC" bundle:nil];
    [controller setupData:indexPath];

    // Pass the selected object to the new view controller.
    // Push the view controller.

    [self.navigationController pushViewController:controller animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"=========prepare for segue========");
}

/*
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  120.0f;
}

- (NSString *)convertPosterUrlStringToHighRes:(NSString *)urlString {
    NSRange range = [urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue = urlString;
    if (range.length > 0) {
        returnValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    return returnValue;
}

- (void)reloadData
{
    //data model reload data
    self.dataModel = [[RottenTomatoDataModel alloc] init];
    if (self.curPage < [[MovieListDataObject sharedInstance] totalMovies]) {
        [self.dataModel loadData:++self.curPage completionCallBackBlock:^(NSDictionary *mvData) {
            //data done
            loadingMask.hidden = YES;
            [[MovieListDataObject sharedInstance] reloadDataWithClean:mvData];
            [self.movieTableView reloadData];
            [self.refreshControl endRefreshing];
        }];
    }
    else {
        //all data loaded
    }
    
}

@end
