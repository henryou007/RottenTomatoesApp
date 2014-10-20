//
//  MovieDetailsViewController.m
//  RottenTomatoesApp
//
//  Created by Jin You on 10/18/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *descriptionScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsisLabel;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.movieTitleLabel.text = self.movie[@"title"];
    self.movieRatingLabel.text = [NSString stringWithFormat:@"Rating: %@", self.movie[@"mpaa_rating"]];
    self.movieSynopsisLabel.text = self.movie[@"synopsis"];
    [self.movieSynopsisLabel sizeToFit];
    
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in self.descriptionScrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [self.descriptionScrollView setContentSize:CGSizeMake(320, scrollViewHeight+50)];
    [self.descriptionScrollView setScrollEnabled:YES];
    
    NSString *posterUrlString = [self.movie valueForKeyPath:@"posters.thumbnail"];
    [self.posterImageView setImageWithURL:[NSURL URLWithString:posterUrlString]];
    posterUrlString = [posterUrlString stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];
    [self.posterImageView setImageWithURL:[NSURL URLWithString:posterUrlString]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
