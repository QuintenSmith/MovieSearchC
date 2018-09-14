//
//  MovieClient.m
//  MovieSearchC
//
//  Created by Quinten Smith on 9/14/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

#import "MovieClient.h"

@implementation MovieClient

+ (MovieClient *)shared
{
    static MovieClient *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [MovieClient new];
    });
    return shared;
}

+ (NSURL *)baseUrl{
    return [[NSURL alloc] initWithString:@"https://api.themoviedb.org/3/search/movie"];
}

+ (void)fetchMoviesForTitle:(NSString *)title withBlock:(void(^_Nullable)(NSArray<Movie *> * _Nullable movie))block
{

    //1) Construct the URL
    NSURL *url = [MovieClient baseUrl];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:YES];
    NSURLQueryItem *queryItem = [[NSURLQueryItem alloc] initWithName:@"query" value:title];
    NSURLQueryItem *apiKey = [[NSURLQueryItem alloc] initWithName:@"api_key" value:@"c1a4264eb223dd9d811e5630d66dbfca"];
    components.queryItems = [[NSArray alloc] initWithObjects:queryItem, apiKey, nil];
//   components.queryItems = [[NSArray alloc] initWithObjects:apiKey, nil];
    NSURL *finishedUrl = components.URL;
    
    NSLog(@"%@", finishedUrl);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finishedUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error){
            NSLog(@"Error in %s, %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            block(nil);
            return;
        }
        NSLog(@"%@", response);
        
        if (!data){
            NSLog(@"NO DATA AVAILABLE");
            block(nil);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *movieDictionaries = jsonDictionary[@"results"];
        
        NSMutableArray *movieArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *movieDict in movieDictionaries){
            Movie * movie = [[Movie alloc] initWithDictionary:movieDict];
            [movieArray addObject:movie];
        }
        block(movieArray);
    }] resume];
    
}

@end
