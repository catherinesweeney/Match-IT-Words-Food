//
//  ImageCache.h
//  NHMatch
//
//  Created by Catherine Sweeney on 11/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>


@interface ImageCache : NSObject {
    
}

+ (UIImage*)loadImage:(NSString*)imageName;
+ (void)releaseCache;

@end

