//
//  MoviesViewController.h
//  RottenTomatoesApp
//
//  Created by Jin You on 10/18/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (instancetype) initWithUrlString:(NSString *) urlString andTabTitle:(NSString *) title;

@end