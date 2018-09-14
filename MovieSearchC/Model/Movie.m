//
//  Movie.m
//  MovieSearchC
//
//  Created by Quinten Smith on 9/14/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _rating = dictionary[@"vote_average"];
        _summary = dictionary[@"overview"];
    }
    return self;
}

@end
