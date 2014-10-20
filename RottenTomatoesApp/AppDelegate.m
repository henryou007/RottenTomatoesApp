//
//  AppDelegate.m
//  RottenTomatoesApp
//
//  Created by Jin You on 10/18/14.
//  Copyright (c) 2014 Henryyou. All rights reserved.
//

#import "AppDelegate.h"
#import "MoviesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSString *moviesRequestUrl = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=rh8p4z28bfxmrp96jp2b9y9b&country=us";
    NSString *dvdsRequestUrl = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json?apikey=rh8p4z28bfxmrp96jp2b9y9b";
    
    MoviesViewController *moviesViewController = [[MoviesViewController alloc] initWithUrlString:moviesRequestUrl andTabTitle:@"Movies"];
    UINavigationController *moviesNavigationController = [[UINavigationController alloc] initWithRootViewController:moviesViewController];
    [moviesNavigationController.tabBarItem setImage:[UIImage imageNamed:@"movieIcon.jpg"]];
    MoviesViewController *dvdsViewController = [[MoviesViewController alloc] initWithUrlString:dvdsRequestUrl andTabTitle:@"DVDs"];
    UINavigationController *dvdsNavigationController = [[UINavigationController alloc] initWithRootViewController:dvdsViewController];
    [dvdsNavigationController.tabBarItem setImage:[UIImage imageNamed:@"dvdIcon.jpg"]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTranslucent:YES];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor yellowColor], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"System" size:30.0], NSFontAttributeName, nil]];
    
    NSArray *myViewControllers = [[NSArray alloc] initWithObjects:
                                  moviesNavigationController,
                                  dvdsNavigationController, nil];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:myViewControllers];
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setTranslucent:YES];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
