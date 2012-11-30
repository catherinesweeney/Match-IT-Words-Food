//
//  draw2D.m
//  NHMatch
//
//  Created by Catherine Sweeney on 16/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "drawAnalytics.h"

@implementation drawAnalytics






- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSString *) getDBPath {
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"MatchIt.sqlite"];
}

- (void)drawRect:(CGRect)rect {
    NSInteger max_time,max_time1,max_time2,max_time3;
    NSInteger border_left=80;
    NSInteger border_top=60;
    NSInteger graph_width=400;
    NSInteger graph_height=300;
    NSInteger plotY1,plotY2;
    CGContextRef context;
    UILabel *seriesLabel;
    NSInteger t,i;

    for (UIView *subview in [self subviews]) {
        // Only remove the subviews with tag > 100 lights
        if (subview.tag >= 300) {
            [subview removeFromSuperview];
        }
    }
    
    context = UIGraphicsGetCurrentContext();    
    CGContextSetLineWidth(context, 4.0);
    /*set color*/
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    /*draw x axis*/
    CGContextMoveToPoint(context, border_left, border_top+graph_height);
    CGContextAddLineToPoint(context, border_left+graph_width,border_top+graph_height);
    CGContextStrokePath(context);
 
   
    /*draw y axis*/
    CGContextMoveToPoint(context, border_left, border_top);
    CGContextAddLineToPoint(context, border_left,border_top+graph_height);
    CGContextStrokePath(context);


    
    /*set color*/
    [self getAnalytics:[self getDBPath]];
    [self getCurrentSeries:[self getDBPath]];  /*sets the labels*/
     max_time = 0;    
     max_time1 = 0;    
     max_time2 = 0;    
     max_time3 = 0;
    
    CGRect labelFrame;
    UILabel* graphLabel;
    NSInteger tag_no = 300;
   
     
    /*X Axis Label*/
    labelFrame = CGRectMake( border_left+(graph_width/3),border_top+graph_height+40 , 200, 30 );
    graphLabel = [[UILabel alloc] initWithFrame: labelFrame];
    [graphLabel setText: @"Activity Completed"];
    [graphLabel setTextColor: [UIColor blueColor]];
    graphLabel.tag = tag_no;
    tag_no++;
    [self addSubview: graphLabel];

    /*draw x axis points*/
    CGContextSetLineWidth(context, 1.0);
    for (NSInteger i=0;i<10;i++)
    {
        CGContextMoveToPoint(context, border_left+(graph_width/10*(i+1)), border_top+graph_height-5);
        CGContextAddLineToPoint(context, border_left+(graph_width/10*(i+1)),border_top+graph_height+5);
        CGContextStrokePath(context);
        /*X Axis point labels*/
        labelFrame = CGRectMake( border_left+(graph_width/10*(i+1))-10,border_top+graph_height+10 , 30, 20 );
        graphLabel = [[UILabel alloc] initWithFrame: labelFrame];
        [graphLabel setTextColor: [UIColor blueColor]];
        [graphLabel setText: [NSString stringWithFormat:@"%d", i+1]];
        graphLabel.font = [UIFont systemFontOfSize:14.0];
        graphLabel.tag = tag_no;
        tag_no++;
        [self addSubview: graphLabel];
    }
 
    /*get max time for y axis*/
    for (NSInteger j=0;j<10;j++)
    {
        if (Graph1Values[0][j]> max_time1)
        {
            max_time1 = Graph1Values[0][j];
            if (max_time1 > max_time)
                max_time=max_time1;
        }
        if (Graph2Values[0][j]> max_time2)
        {
            max_time2 = Graph2Values[0][j];
            if (max_time2 > max_time)
                max_time = max_time2;
        }
        if (Graph3Values[0][j]> max_time)
        {
            max_time3 = Graph3Values[0][j];
            if (max_time3 > max_time)
                max_time = max_time3;
        }
    }

    /* max time > 5 mins move axis to mins*/
    NSInteger y;
    if (max_time >= 300)
        y = 60;
    else
        y=1;
    
    /* Y Axis Label*/
    labelFrame = CGRectMake( 0, border_top+(graph_height)/2, 45, 30 );
    graphLabel = [[UILabel alloc] initWithFrame: labelFrame];
    [graphLabel setTextColor: [UIColor blueColor]];
    if (y == 1)
        [graphLabel setText: @"Secs"];
    else
        [graphLabel setText: @"Mins"];        
    graphLabel.tag = tag_no;
    tag_no++;
    [self addSubview: graphLabel];

    max_time=max_time/y;
    NSInteger z = max_time%5;
    if (z != 0)
        max_time = max_time + (5-z);
    if (max_time>=5)
        t = max_time/5;
    else
        t=1;
    for (i=1;i<=(max_time/t);i++)
    {
        CGContextMoveToPoint(context, border_left-5, border_top+graph_height-(graph_height/max_time*t*i));
        CGContextAddLineToPoint(context, border_left+5, border_top+graph_height-(graph_height/max_time*t*i));
        CGContextStrokePath(context);
        /*y Axis point labels*/
        labelFrame = CGRectMake( border_left-30, border_top+graph_height-(graph_height/max_time*t*i)-10
                                , 25, 20 );
        graphLabel = [[UILabel alloc] initWithFrame: labelFrame];
        [graphLabel setTextColor: [UIColor blueColor]];
        [graphLabel setText: [NSString stringWithFormat:@"%d", t*i]];
        graphLabel.textAlignment = UITextAlignmentRight;
        graphLabel.font = [UIFont systemFontOfSize:14.0];
        graphLabel.tag = tag_no;
        tag_no++;
        [self addSubview: graphLabel];
    }

    
    /*Max Y Label
    labelFrame = CGRectMake( border_left-20, border_top, 30, 15);
    graphLabel = [[UILabel alloc] initWithFrame: labelFrame];
    [graphLabel setTextColor: [UIColor blueColor]];
  [graphLabel setText: [NSString stringWithFormat:@"%d", max_time]];
    [self addSubview: graphLabel];*/
    
    [graphLabel release];
   
    /*add or update series labels*/
    labelFrame = CGRectMake( border_left+graph_width+20, border_top, 100, 30 );
    seriesLabel = [[UILabel alloc] initWithFrame: labelFrame];
    [seriesLabel setTextColor: [UIColor orangeColor]];
    [seriesLabel setText:series1Name];
    seriesLabel.tag = tag_no;
    tag_no++;
    [self addSubview: seriesLabel];
    
    labelFrame = CGRectMake( border_left+graph_width+20, border_top+40, 100, 30 );
    seriesLabel = [[UILabel alloc] initWithFrame: labelFrame];
    [seriesLabel setTextColor: [UIColor greenColor]];
    [seriesLabel setText:series2Name];
    seriesLabel.tag = tag_no;
    tag_no++;
    [self addSubview: seriesLabel];
    
    labelFrame = CGRectMake( border_left+graph_width+20, border_top+80, 100, 30 );
    seriesLabel = [[UILabel alloc] initWithFrame: labelFrame];
    [seriesLabel setTextColor: [UIColor purpleColor]];
    [seriesLabel setText:series3Name];
    seriesLabel.tag = tag_no;
    tag_no++;
    [self addSubview: seriesLabel];

    
    
    if (max_time1 != 0)  /*DRAW GRAPH 1*/
    {
        CGContextSetLineWidth(context, 2.0);
        /*set color*/
        CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);

        
        for (NSInteger i=0;i<9;i++)
        {
          if ((Graph1Values[0][i] !=0) & (Graph1Values[0][i+1] !=0))
          {
                
            plotY1 = graph_height+border_top-((graph_height/max_time)*Graph1Values[0][i]);
            plotY2 = graph_height+border_top-((graph_height/max_time)*Graph1Values[0][i+1]);
            CGContextMoveToPoint(context, border_left +((i+1)*graph_width/10),plotY1 );
            CGContextAddLineToPoint(context, border_left+((i+2)*graph_width/10),plotY2 );
            CGContextStrokePath(context);
          }
         }
        
 
    }
    
    if (max_time2 != 0) /*DRAW GRAPH 2*/
    {
        CGContextSetLineWidth(context, 2.0);
        /*set color*/
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    for (NSInteger i=0;i<9;i++)
        {
          if (Graph2Values[0][i] !=0 & Graph2Values[0][i+1] !=0)
          {
            plotY1 = graph_height+border_top-((graph_height/max_time)*Graph2Values[0][i]);
            plotY2 = graph_height+border_top-((graph_height/max_time)*Graph2Values[0][i+1]);
            CGContextMoveToPoint(context, border_left+((i+1)*graph_width/10),plotY1 );
            CGContextAddLineToPoint(context, border_left+((i+2)*graph_width/10),plotY2 );
            CGContextStrokePath(context);
          }
        }
   }
      
    if (max_time3 != 0) /*DRAW GRAPH 3*/
    {
        CGContextSetLineWidth(context, 2.0);
        /*set color*/
        CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);

        for (NSInteger i=0;i<9;i++)
        {
          if (Graph3Values[0][i] !=0 & Graph3Values[0][i+1] !=0)
          {
            plotY1 = graph_height+border_top-((graph_height/max_time)*Graph3Values[0][i]);
            plotY2 = graph_height+border_top-((graph_height/max_time)*Graph3Values[0][i+1]);
            CGContextMoveToPoint(context, border_left+((i+1)*graph_width/10),plotY1 );
            CGContextAddLineToPoint(context, border_left+((i+2)*graph_width/10),plotY2 );
            CGContextStrokePath(context);
          }
        }
    }
}

-(void) getAnalytics:(NSString *)dbPath 
{
    sqlite3_stmt    *statement;
    NSInteger i=0;
    NSString *querySQL;
    const char *query_stmt;
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        querySQL = [NSString stringWithFormat: @"select * from (select level, score_date,secs_taken,comb_id,s.rowid from scores s,currentsettings cs,users u where level = u.analytics_series1  and s.user_id = u.user_id  and s.user_id = cs.user_id  order by s.rowid desc limit 10)order by rowid asc "];
        
        query_stmt = [querySQL UTF8String];
 
        if (sqlite3_prepare_v2(matchDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Graph1Labels[0][i] =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                Graph1Labels[1][i] =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                Graph1Values[0][i] =   sqlite3_column_int(statement, 2);
                Graph1Values[1][i] =   sqlite3_column_int(statement, 3);
                i++;
            } 
            while (i<10)
            {
                Graph1Values[0][i] = 0;
                Graph1Values[1][i] =   0;
                i++;
                
            }
            sqlite3_finalize(statement);
        }
         querySQL = [NSString stringWithFormat: @"select * from (select level, score_date,secs_taken,comb_id,s.rowid from scores s,currentsettings cs,users u where level = u.analytics_series2  and s.user_id = u.user_id  and s.user_id = cs.user_id  order by s.rowid desc limit 10)order by rowid asc "];
        
        query_stmt = [querySQL UTF8String];
  
        i=0;
        if (sqlite3_prepare_v2(matchDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Graph2Labels[0][i] =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                Graph2Labels[1][i] =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                Graph2Values[0][i] =   sqlite3_column_int(statement, 2);
                 Graph2Values[1][i] =   sqlite3_column_int(statement, 3);
                i++;
            } 
            while (i<10)
            {
                Graph2Values[0][i] = 0;
                Graph2Values[1][i] =   0;
                i++;
                
            }          
            sqlite3_finalize(statement);
        }
        querySQL = [NSString stringWithFormat: @"select * from (select level, score_date,secs_taken,comb_id,s.rowid from scores s,currentsettings cs,users u where level = u.analytics_series3  and s.user_id = u.user_id  and s.user_id = cs.user_id  order by s.rowid desc limit 10)order by rowid asc "];
        
        query_stmt = [querySQL UTF8String];
        i=0;
        if (sqlite3_prepare_v2(matchDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                Graph3Labels[0][i] =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                Graph3Labels[1][i] =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                Graph3Values[0][i] =   sqlite3_column_int(statement, 2);
                 Graph3Values[1][i] =   sqlite3_column_int(statement, 3);
                i++;
            } 
            while (i<10)
            {
                Graph3Values[0][i] = 0;
                Graph3Values[1][i] = 0;
                i++;    
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(matchDB);
    
}

-(void) getCurrentSeries:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    NSInteger iSeries1,iSeries2,iSeries3;
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT analytics_series1,analytics_series2,analytics_series3 from users u,CurrentSettings cs where u.user_id =cs.user_id"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(matchDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                iSeries1 =  sqlite3_column_int(statement, 0);
                  series1Name = [NSString stringWithFormat:@"Level %d",iSeries1];
                iSeries2 =  sqlite3_column_int(statement, 1);
                series2Name = [NSString stringWithFormat:@"Level %d",iSeries2];
                iSeries3 =  sqlite3_column_int(statement, 2);
                series3Name = [NSString stringWithFormat:@"Level %d",iSeries3];
                 
            } else {
                
             }
            sqlite3_finalize(statement);
        }
     }
       sqlite3_close(matchDB);
}

@end
