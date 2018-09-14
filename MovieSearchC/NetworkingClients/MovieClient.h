//
//  MovieClient.h
//  MovieSearchC
//
//  Created by Quinten Smith on 9/14/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface MovieClient : NSObject

+ (MovieClient *) shared;

+ (void)fetchMoviesForTitle:(NSString *)title withBlock:(void(^_Nullable)(NSArray<Movie *> * _Nullable movie))block;

@end
