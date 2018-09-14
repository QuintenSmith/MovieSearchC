//
//  Movie.h
//  MovieSearchC
//
//  Created by Quinten Smith on 9/14/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) NSNumber *rating;
@property (nonatomic, readonly, copy) NSString *summary;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary; 

@end
