//
//  MoviesViewController.m
//  RottenTomatoesApp
//
//  Created by Jin You on 10/18/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieTableViewCell.h"
#import "MovieDetailsViewController.h"

#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

#define ARC4RANDOM_MAX 0x100000000

@interface MoviesViewController ()

@property (strong, nonatomic) NSString *urlString;

@property (weak, nonatomic) IBOutlet UIView *networkErrorBarView;
@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;
@property (strong, nonatomic) NSArray *movieData;
@property (strong,nonatomic) UIRefreshControl *listRefreshControl;

@end

@implementation MoviesViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (instancetype) initWithUrlString:(NSString *) urlString andTabTitle:(NSString *) title {
    self = [super init];
    
    self.urlString = urlString;
    self.title = title;

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listRefreshControl = [[UIRefreshControl alloc] init];
    [self.listRefreshControl addTarget:self action:@selector(loadMovieData) forControlEvents:UIControlEventValueChanged];
    [self.moviesTableView insertSubview:self.listRefreshControl atIndex:0];
    
    // Do any additional setup after loading the view from its nib.
    self.moviesTableView.delegate = self;
    self.moviesTableView.dataSource = self;
    self.moviesTableView.rowHeight = 150;
    [self.networkErrorBarView setHidden:YES];
    
    [self.moviesTableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieTableViewCell"];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    [self loadMovieData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell"];;
    NSDictionary *movie = self.movieData[indexPath.row];
    movieCell.movieTitleLabel.text = movie[@"title"];
    movieCell.movieSynopsisLabel.text = movie[@"synopsis"];
    [movieCell.movieImageView setImageWithURL: [NSURL URLWithString:[movie valueForKeyPath:@"posters.thumbnail"]]];
    movieCell.movieImageView.alpha = 0.0;
    [UIView animateWithDuration:0.5
                          delay:((float)arc4random() / ARC4RANDOM_MAX)
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ movieCell.movieImageView.alpha = 1; }
                     completion:^(BOOL finished){}
     ];
    return movieCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieDetailsViewController *movieDetailViewController = [[MovieDetailsViewController alloc] init];
    movieDetailViewController.movie = self.movieData[indexPath.row];
    [self.navigationController pushViewController:movieDetailViewController animated:YES];
}

- (void) loadMovieData {
    NSString *requestUrlString = self.urlString;
    NSURL *url = [NSURL URLWithString:requestUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            [self.networkErrorBarView setHidden:NO];
        } else {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movieData = responseDictionary[@"movies"];
            [self.moviesTableView reloadData];
            
            [self.networkErrorBarView setHidden:YES];
        }
        
        [SVProgressHUD dismiss];
        [self.listRefreshControl endRefreshing];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
