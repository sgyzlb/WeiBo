//
//  NSURLRequest+Url.h
//  WeiBo
//
//  Created by Aven on 3/29/14.
//  Copyright (c) 2014 GML. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Url)

+(NSURLRequest *)requestWithPath:(NSString *)path
                          params:(NSDictionary *)params;

@end
