 //
//  ImageCache.m
//  NHMatch
//
//  Created by Catherine Sweeney on 11/09/2012.
//  Copyright (c) 2012 
//

#import "ImageCache.h"

@implementation ImageCache

static NSMutableDictionary *dict;

+ (UIImage*)loadImage:(NSString*)imageName
{
	if (!dict) 
        dict = [[NSMutableDictionary dictionary] retain];
	
	UIImage* image = [dict objectForKey:imageName];
	if (!image)
	{
		NSString* imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];	
		image = [UIImage imageWithContentsOfFile:imagePath];
		if (image)
		{
			[dict setObject:image forKey:imageName];
		}
	}
	
	return image;
}

+ (void)releaseCache {
	if (dict) {
		[dict removeAllObjects];
	}
}

@end