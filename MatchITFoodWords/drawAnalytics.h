//
//  draw2D.h
//  NHMatch
//
//  Created by Catherine Sweeney on 16/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <sqlite3.h>


@interface drawAnalytics : UIView{
    NSString *databasePath;
    sqlite3 *matchDB; 
    NSString *Graph1Labels[3][10];
    NSInteger Graph1Values[2][10];
    NSString *Graph2Labels[3][10];
    NSInteger Graph2Values[2][10];
    NSString *Graph3Labels[3][10];
    NSInteger Graph3Values[2][10];
    UITextField *GraphTable[4][10];
    NSString *series1Name;
    NSString *series2Name;
    NSString *series3Name;
    

}
- (NSString *) getDBPath;

- (void) getAnalytics:(NSString *)dbPath;
- (void) getCurrentSeries:(NSString *)dbPath;


@end
