//
//  ViewController.m
//  MatchITFoodWords
//
//  Created by Catherine Sweeney on 19/11/2012.
//  Copyright (c) 2012 Catherine Sweeney. All rights reserved.
//


#import "ViewController.h"

#import "ImageCache.h"





@implementation ViewController
@synthesize
first_name, last_name,
viewSettings, viewActivity,viewHelp,viewResults,viewBackground,viewAnalytics,
user_name, user_score,user_max_score,game_status,user_level,
result_message1,result_message2,result_message3,
bbarHelp,helpText,helpTitle,
btnUser1,btnUser2,btnUser3,btnUser4,
swMatchSound,swResultsSound,swHelpVoice,
activity_mins,activity_secs,best_mins,best_secs,
imgTarget,imgDist1,
analytics_title,graphControl;

- (void) dealloc
{
    [first_name release];
    [last_name release];
    [viewSettings release];
    [viewActivity release];
    [viewHelp release];
    [viewResults release];
    [viewBackground release];
    [viewAnalytics release];
    [user_name release];
    [user_score release];
    [user_max_score release];
    [game_status release];
    [user_level release];
    [result_message1 release];
    [result_message2 release];
    [bbarHelp release];
    [helpText release];
    [helpTitle release];
    [btnUser1 release];
    [btnUser2 release];
    [btnUser3 release];
    [btnUser4 release];
    [swMatchSound release];
    [swResultsSound release];
    [swHelpVoice release];
    [activity_mins release];
    [activity_secs release];
    [imgTarget release];
    [imgDist1 release];
}

/*SPLASH SCREEN LOAD
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 
 {
 imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splashscreen.png"]];
 imageView.frame = CGRectMake(0, 0, 324, 480);
 [window addSubview:imageView];
 [self.window makeKeyAndVisible];
 
 [self performSelector:@selector(firstscreen) withObject:nil afterDelay:1.0];
 return YES;
 }
 
 
 -(void)firstscreen
 {
 // Load some View
 
 }*/

- (void)viewDidLoad
{
    [self setTitle:@"Neuro Hero - Match IT"];
    
    [self copyDatabaseIfNeeded];
    user_id=1;
    user_mode=0;
    iMatchSound=1; /*replace to get setting from db 8*/
    iHelpVoice = 1;
    iResultsSound= 1;
    
    iButtonPressed = 0;
    
    [self getCurrentUser:[self getDBPath]];
    [self setUser];
    
    game_status.text = @"Awaiting Start";
    
    [super viewDidLoad];
    userTimer=nil;
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    
	// Do any additional setup after loading the view, typically from a nib.
}




- (void)startLevel1
{
    if (iButtonPressed != 1)
    {
        iButtonPressed = 1;
        level =1;
        /*max score = select max score from scores where level = x and user -= y*/
        [self startActivity];
    }
}

- (void) startLevel2
{
    if (iButtonPressed != 1)
    {
        iButtonPressed = 1;
        level =2;
        [self startActivity];
    }
}

- (void) startLevel3
{
    if (iButtonPressed != 1)
    {
        iButtonPressed = 1;
        level =3;
        [self startActivity];
    }
}

- (void) startLevel4
{
    if (iButtonPressed != 1)
    {
        iButtonPressed = 1;
        level =4;
        [self startActivity];
    }
}

- (void) startLevel5
{
    if (iButtonPressed != 1)
    {
        iButtonPressed = 1;
        level =5;
        [self startActivity];
    }
}

- (void) startLevel6
{
    if (iButtonPressed !=1)
    {
        iButtonPressed = 1;
        level =6;
        [self startActivity];
    }
}

- (void) startLevel7
{
    if (iButtonPressed != 1)
    {
        iButtonPressed = 1;
        level =7;
        [self startActivity];
    }
}

- (void) startLevel8
{
    if (iButtonPressed != 1)
    {
        iButtonPressed = 1;
        level =8;
        [self startActivity];
    }
}

- (void) startLevel9
{
    if (iButtonPressed != 1)
    {
        iButtonPressed = 1;
        level =9;
        [self startActivity];
    }
}

/************************************************************/
/*********** S T A R T   A C T I V I T Y  *******************/
/************************************************************/

- (void) startActivity
{
    NSInteger bMins,bSecs;
    /*set variable values*/
    touchdown=0;
    [self getTopScore:[self getDBPath]];
    if (max_score < 60)
        bMins = 0;
    else
        bMins = max_score/60;
    best_mins.text = [NSString stringWithFormat:@"%d", bMins];
    bSecs = max_score%60;
    if (bSecs < 10)
        best_secs.text = [NSString stringWithFormat:@"0%d", bSecs];
    else
        best_secs.text = [NSString stringWithFormat:@"%d", bSecs];
    
    touchdown=0;
    stopcard = 100;
    
    score = 0;
    play_status = 1;
    screen_width = 1024;
    screen_height = 600;
    top_height = 350;
    bottom_height = screen_height - top_height;
    base_level = level % 3;
    card_width = 120;
    card_height = card_width/3*2;
    minX = (card_width/2)+20;
    maxX = screen_width - (card_width/2)-20;
    minY = top_height - 150;
    maxY = screen_height+card_height/2;
    no_objects = 12;
    round_no = 0;
    
    /*load lights*/
    green_light = @"green_light.png";
    off_light = @"off_light.png";
    glightImage = [ImageCache loadImage: green_light];
    olightImage = [ImageCache loadImage: off_light];
    
    /*initialise clock*/
    currentSecs=0;
    currentMins=0;
    activity_mins.text = [NSString stringWithFormat:@"%d", currentMins];
    activity_secs.text = [NSString stringWithFormat:@"%d", currentSecs];
    [self initialiseClock];
    
    /* user_level.text =[@"Level " stringByAppendingFormat:"%d",level];*/
    /*set labels*/
    game_status.text = @"Activity In Progress";
    user_level.text =  [NSString stringWithFormat:@"%d", level];
    user_score.text =  [NSString stringWithFormat:@"%d", score];
    user_max_score.text =  [NSString stringWithFormat:@"%d", max_score];
    
    
    /*load background and activity screens*/
    [self.view addSubview:viewBackground ] ;
    [self.view addSubview:viewActivity ] ;
    viewActivity.multipleTouchEnabled=NO;
    viewActivity.exclusiveTouch=YES;
    
    /*assign images*/
    [self getObjects:[self getDBPath]];
    while (targetName1==NULL||dist1Name1==NULL)
        [self getObjects:[self getDBPath]];
    
    NSString *file_ext = @"pcard.png";
    targetName = [targetName1 stringByAppendingString:file_ext];
    dist1Name = [dist1Name1 stringByAppendingString:file_ext];
    imgTarget.image = [UIImage imageNamed: targetName];
    imgDist1.image = [UIImage imageNamed: dist1Name];
    /*imgTarget.image = [UIImage imageNamed: file_blank];
    imgDist1.image = [UIImage imageNamed: file_blank];*/
    UITextField* textField = [[UITextField alloc]
                              initWithFrame:CGRectMake(10, card_height/2-20, card_width-10, 40) ];
    textField.font =  [UIFont systemFontOfSize:20.0f ];
    textField.placeholder = targetName1;
    textField.tag = 500;
    
    [imgTarget addSubview:textField];
    [textField setValue:[UIColor darkGrayColor]forKeyPath:@"_placeholderLabel.textColor"];
    UITextField* textField1 = [[UITextField alloc]
                              initWithFrame:CGRectMake(10, card_height/2-20, card_width-10, 40)];
    textField1.font =  [UIFont systemFontOfSize:20.0f];
    textField1.placeholder = dist1Name1;
    textField1.tag = 501;
    [textField1 setValue:[UIColor darkGrayColor]forKeyPath:@"_placeholderLabel.textColor"];
    [imgDist1 addSubview:textField1];
    
    
    targetSoundFile = [[NSBundle mainBundle] pathForResource:targetName1 ofType:@"wav"];
    targetSoundURL = [NSURL fileURLWithPath:targetSoundFile];
    AudioServicesCreateSystemSoundID((CFURLRef)targetSoundURL, &targetSound);
    
    dist1SoundFile = [[NSBundle mainBundle] pathForResource:dist1Name1 ofType:@"wav"];
    dist1SoundURL = [NSURL fileURLWithPath:dist1SoundFile];
    AudioServicesCreateSystemSoundID((CFURLRef)dist1SoundURL, &dist1Sound);
    
    if (base_level == 2 || base_level==0)
    {
       /* dist2Name = [dist2Name1 stringByAppendingString:file_ext];
        imgDist2.image = [UIImage imageNamed: dist2Name];*/
    }
    
    switch (base_level)  /*change to select from database*/
    {
        case 1:
            no_cards = 4;
            no_matches = 4;
            break;
        case 2:
            no_cards = 6;
            no_matches = 4;
            break;
        case 0:
            no_cards= 9;
            no_matches = 6;
            break;
        default:
            no_cards = 1;
            break;
    }
    
    max_round = no_objects / no_matches;
    card_area_width = screen_width / no_cards;
    
    /*draw lights*/
    NSInteger x;
    for(x=0;x<(no_matches*max_round);x++){
        imgLights[x] = [[[UIImageView alloc] initWithImage:olightImage] autorelease];
        /*imgLights[x].image = [UIImage imageNamed:@"off_light.png"];*/
        CGRect newFrame = imgLights[x].frame;
        newFrame.origin = CGPointMake(20*(x+1),90);  /*replace with parameters*/
        newFrame.size = CGSizeMake(15,15);
        imgLights[x].frame = newFrame;
        imgLights[x].tag = x+100;
        [viewActivity addSubview:imgLights[x]];
    }
    
    switch (no_cards)
case 4:
    {
        matchCards[0]=targetName1;
        matchCards[1]=targetName1;
        matchCards[2]=dist1Name1;
        matchCards[3]=dist1Name1;
        break;
    case 6:
        matchCards[0]=targetName1;
        matchCards[1]=targetName1;
        matchCards[2]=dist1Name1;
        matchCards[3]=dist1Name1;
        matchCards[4]=dist2Name1;
        matchCards[5]=dist2Name1;
        break;
    case 9:
        matchCards[0]=targetName1;
        matchCards[1]=targetName1;
        matchCards[2]=targetName1;
        matchCards[3]=dist1Name1;
        matchCards[4]=dist1Name1;
        matchCards[5]=dist1Name1;
        matchCards[6]=dist2Name1;
        matchCards[7]=dist2Name1;
        matchCards[8]=dist2Name1;
        break;
    }
    /*  [ImageCache releaseCache];*/
    [self layoutCards]; /*shuffle and random display round 1*/
    
}

- (void) layoutCards
{
    NSString *temp;
    NSInteger x,y,z,i,r,r1,r2;
    UIImage *cardImage;
    CGRect newFrame;
    
    round_no++;
    match_objects = no_matches;
    
    /*shuffle cards first time*/
    if (round_no == 1)
    {
        for (i = 0; i < (no_cards-1); i++)
        {
            r = (arc4random() % (no_cards-i));
            temp = matchCards[no_cards-i-1];
            matchCards[no_cards-i-1] = matchCards[r];
            matchCards[r]=temp;
        }
        
    }
    y=0;
    /* layout cards*/
    NSString *blank;
    if (round_no == 1){
        for(x=0;x<no_cards;x++)
        {
            if (x > 0)
                z=y;
            else
                z=0;
            blank=@"blankpcard.png";
           /* NSString* imagePath = [[NSBundle mainBundle] pathForResource:matchCards[x] ofType:nil];*/
            NSString* imagePath = [[NSBundle mainBundle] pathForResource:blank ofType:nil];
            
            cardImage = [UIImage imageWithContentsOfFile:imagePath];
            imgMatch[x] = [[[UIImageView alloc] initWithImage:cardImage] autorelease];
           /* imgMatch[x].userInteractionEnabled = YES;*/
            UILabel *textField = [[UILabel alloc]
                                      initWithFrame:CGRectMake(5, (card_height/2)-20, card_width-10, 40)];
            
            textField.font =  [UIFont systemFontOfSize:20.0f];
            textField.text=matchCards[x];
            textField.textAlignment = UITextAlignmentCenter;
             [imgMatch[x] addSubview:textField];
            [textField setTextColor:[UIColor darkGrayColor]];
            /* [textField setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];*/
            newFrame = imgMatch[x].frame;
            
            do {
                y = (arc4random() % bottom_height) +1;
            }
            while (abs(y-z)<100 && (z>0)); /*random position for card*/
            
            newFrame.origin = CGPointMake(((card_area_width/2) + (x*card_area_width)-(card_width/2)),y+top_height-(card_height/2));
            if (card_area_width < card_width)
                if (x==0)
                {
                    newFrame.origin = CGPointMake(20,y+top_height-(card_height/2));
                }
                else
                {
                    if (x==(no_cards-1))
                        newFrame.origin = CGPointMake(screen_width-card_width-20,y+top_height-(card_height/2));
                }
            newFrame.size = CGSizeMake(card_width,card_height);
            imgMatch[x].frame = newFrame;
            imgMatch[x].tag =x+200;
            [viewActivity addSubview:imgMatch[x]]; /*display card*/
            
        }
    }
    y=0;
    
    if (round_no > 1)
    {
        for(x=0;x<no_cards;x++)
        {
            if (x > 0)
                z=y;
            else
                z=0;
            do {
                y = (arc4random() % bottom_height) +1;
            }
            while (abs(y-z)<100 && (z>0)); /*random position for card*/
            imgMatch[x].center = CGPointMake(((card_area_width/2) + (x*card_area_width)),y+top_height);
            if (card_area_width < card_width)
                if (x==0)
                    imgMatch[x].center = CGPointMake((card_area_width/2)+20,y+top_height);
                else if (x==(no_cards-1))
                    imgMatch[x].center = CGPointMake(screen_width-(card_width/2)-20,y+top_height);
            imgMatch[x].hidden=FALSE;
        }
    }
    
    /*random card movement*/
    if (level >=4 && round_no == 1)
    {
        
        for (i=0;i<no_cards;i++)
        {
            r1= arc4random() % 2;
            if (r1==0)
                r1 = -2;
            else
                r1 = 2;
            r2= arc4random() % 2;
            if (r2==0)
                r2 = -2;
            else
                r2 = 2;
            cardMovement[i] = CGPointMake(r1,r2);
        }
        [self initialiseTimer];
    }
    
}

/************************************************************/
/*********** A C T I V I T Y   T O U C H E S ****************/
/************************************************************/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touchdown++;
    if (touchdown == 1)
    {
        NSInteger i,touchY,touchX,imgX,imgY;
        om=10;
        match = 0;
        
        if (play_status==1)
        {
            
            UITouch *touch = [[event allTouches] anyObject];
            touchXOffset=card_width;
            touchYOffset=card_height;
            
            for  (i = 0; i<no_cards; i++)
            {
                touchY=[touch locationInView:touch.view].y;
                touchX=[touch locationInView:touch.view].x;
                imgX = imgMatch[i].center.x ;
                imgY = imgMatch[i].center.y;
                touchXOffset = imgX - touchX;
                touchYOffset = imgY - touchY;
                /*condition if card touched and in range of card movement*/
                if ((abs(touchXOffset)<=card_width/2 && abs(touchYOffset)<=card_height/2 && touchY > top_height))
                {
                    stopcard = i;
                    /* [theTimer invalidate];
                     theTimer = nil;
                     [self initialiseTimer];  */
                    
                    sx = imgMatch[i].center.x;  /*start position*/
                    sy = imgMatch[i].center.y;
                    om = i;
                    [viewActivity bringSubviewToFront:imgMatch[om]];  /*bring image to front*/
                }
            }
            
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if ((play_status==1) && (om != 10))
    {
        UITouch *touch = [[event allTouches] anyObject];
        float distancexMoved = [touch locationInView:touch.view].x - imgMatch[om].center.x;
        float distanceyMoved = [touch locationInView:touch.view].y  - imgMatch[om].center.y;
        if (abs(distanceyMoved) < ((card_height/2)+ 10) && abs(distancexMoved) < ((card_width/2)+10))
        {
            float newX = imgMatch[om].center.x + distancexMoved;
            float newY = imgMatch[om].center.y + distanceyMoved;
            
            if ((newX > minX && newX < maxX ) && (newY > minY && newY < maxY))
            {
                imgMatch[om].center = CGPointMake( newX, newY );
            }
        }
    }
    
}

-(void)stopSound
{
    AudioServicesDisposeSystemSoundID(activityHelpSound);
    /*   AudioServicesDisposeSystemSoundID(targetSound);
     AudioServicesDisposeSystemSoundID(dist1Sound);
     AudioServicesDisposeSystemSoundID(resultsSound);*/
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    float distancexMoved = [touch locationInView:touch.view].x - imgMatch[om].center.x;
    float distanceyMoved = [touch locationInView:touch.view].y  - imgMatch[om].center.y;
    if ((abs(distanceyMoved) < ((card_height/2)+ 10) && abs(distancexMoved) < ((card_width/2)+10))|| (touchdown==1))
    {
        
        if (om != 10)
        {
            [self matchObject];
            if (match > 0 && om!=10)
            {
                match_objects--;
                user_score.text =  [NSString stringWithFormat:@"%d", score];
                imgMatch[om].hidden = TRUE;
                /* add in code to remove 300+om tag from superview*/
                
                
                /*if match highlight green light */
                imgLights[score-1].highlighted=TRUE;
                imgLights[score-1].highlightedImage=[UIImage imageNamed:@"green_light.png"];;
                
                if (match == 1)  /*if match play sound*/
                {
                    if(iMatchSound==1)
                    {
                        [self stopSound];
                        
                        AudioServicesPlaySystemSound(targetSound);
                    }
                }
                else
                {
                    if(iMatchSound==1)
                    {
                        [self stopSound];
                        AudioServicesPlaySystemSound(dist1Sound);
                    }
                }
                match=0;
            }
            /*if all matches goto next round , shuffle and layout cards*/
            if (match_objects == 0 && round_no < max_round )
            {
                /* for (int i=0;i<no_cards;i++)
                 {
                 imgMatch[i].hidden = TRUE;
                 }*/
                [self layoutCards];
            }
            else if (match_objects == 0 && round_no == max_round )
            {
                [self endActivity];
            }
        }
        
        [super touchesEnded:touches withEvent:event];
        
        stopcard = 100;
        /*    [theTimer invalidate];
         theTimer = nil;
         [self initialiseTimer]; */
        
    }
    touchdown--;
}

-(IBAction)chgMatchSound{
    
    if(swMatchSound.on)
        iMatchSound = 1;
    else
        iMatchSound = 0;
}


-(IBAction)chgResultsSound{
    
    if(swResultsSound.on)
        iResultsSound = 1;
    else
        iResultsSound = 0;
}

-(IBAction)chgHelpVoice{
    
    if(swHelpVoice.on)
        iHelpVoice = 1;
    else
        iHelpVoice = 0;
}

/************************************************************/
/***********  A C T I V I T Y   M A T C H I N G *************/
/************************************************************/

- (void) matchObject
{
    NSInteger matchYDist = ((160+80)/2)-20;
    NSInteger matchXDist = ((240+120)/2)-20;
    /*user_score.text = @"Score 0" ;*/
    
    /*if match move image to centre and set match value so it can be removed and sound played*/
	if ((abs(imgMatch[om].center.x - imgTarget.center.x) < matchXDist) && (abs(imgMatch[om].center.y - imgTarget.center.y) < matchYDist) && (match == 0) )
    {
        if (matchCards[om] == targetName1)
        {
            match =1;
            imgMatch[om].center = CGPointMake( imgTarget.center.x, imgTarget.center.y );
            score=score+1;
            /*   wait(1);*/
            
        }
        else /*return to original postion*/
        {
            imgMatch[om].center = CGPointMake( sx, sy );
        }
    }
    else if
        ((abs(imgMatch[om].center.x - imgDist1.center.x) < matchXDist) && (abs(imgMatch[om].center.y - imgDist1.center.y) < matchYDist) && (match == 0) )
    {
        if (matchCards[om] == dist1Name1)
        {
            match =2;
            score=score+1;
            imgMatch[om].center = CGPointMake( imgDist1.center.x, imgDist1.center.y );
        }
        else /*return to original postion*/
        {
            imgMatch[om].center = CGPointMake( sx, sy );
        }
    }
    else if (imgMatch[om].center.y < top_height)
        imgMatch[om].center = CGPointMake( sx, sy );  /*can't ,move to top section of screen unless matching*/
    /* else
     {
     for (NSInteger i=0;i<no_objects;i++)
     {
     if (i!= om && (abs(imgMatch[om].center.x - imgMatch[i].center.x) <= card_width) && (abs(imgMatch[om].center.y - imgMatch[i].center.y) <= card_height))
     {
     imgMatch[om].center = CGPointMake( sx, sy );
     
     }
     
     }
     }*/
}




- (void) updateClock:(NSTimer *)theClock
{
    
    currentSecs++;
    if (currentSecs==60)
    {
        currentMins++;
        activity_mins.text = [NSString stringWithFormat:@"%d", currentMins];
        currentSecs=0;
    }
    if (currentMins==60)
    {
        [self endActivity];  /*timeout at 1 hour*/
    }
    if (currentSecs < 10)
        activity_secs.text = [NSString stringWithFormat:@"0%d", currentSecs];
    else
        activity_secs.text = [NSString stringWithFormat:@"%d", currentSecs];
}

- (void) endActivityMsg
{
    [theTimer invalidate];
    theTimer = nil;
    [theClock invalidate];
    theClock = nil;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Quit Actvity"
                                                    message:@"Are you sure?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Quit",nil];
    [alert show];
    [alert release];
}
- (void) endActivity
{
    
    [theTimer invalidate];
    theTimer = nil;
    [theClock invalidate];
    theClock = nil;
    play_status = 0;
    if (score < no_objects)
    {
        
        [ImageCache releaseCache];
        [self closeResults];
    }
    else
        [self performSelector:@selector(openviewResults) withObject:nil afterDelay:1.0]; /*open results after 1 sec*/
    
}



- (void) pauseActivity
{
    [theTimer invalidate];
    theTimer = nil;
    [theClock invalidate];
    theClock = nil;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Activity Paused"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Resume"
                                          otherButtonTitles:nil];
    /*    alert.tag = @"aPause";*/
    [alert show];
    [alert release];
}



- (void)alertView:(UIAlertView *)alertView  clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    /*   if (alertView.tag == aPause)*/
    if  (buttonIndex == 0)
    {
        if (level >=4 )
        {
            /* card movement*/
            
            [self initialiseTimer];
        }
        [self initialiseClock];
    }
    else
        [self endActivity];
}

- (void)initialiseTimer
{
    float theInterval;
    
    if (theTimer == nil && level >= 4)
    {
        if (level < 7)
            theInterval = 1.0/10.0; /*slow*/
        else
            theInterval = 1.0/40.0; /*fast*/
        theTimer=[NSTimer scheduledTimerWithTimeInterval:theInterval target:self selector:@selector(moveCards:) userInfo:nil repeats:YES];
    }
}

- (void)initialiseClock
{
    if (theClock == nil)
    {
        float theInterval = 1.0; /*1 second*/
        
        theClock=[NSTimer scheduledTimerWithTimeInterval:theInterval target:self selector:@selector(updateClock:) userInfo:nil repeats:YES];
    }
}

- (void) moveCards:(NSTimer *)theTimer
{
    NSInteger i;
    /*BOOL cardCollision;*/
    
    for ( i=0;i<no_cards;i++){
        if (i!=stopcard)
        {
            /*cards collide with sides then reverse direction*/
            if (imgMatch[i].center.x  < minX || imgMatch[i].center.x  > maxX )
                cardMovement[i].x = -cardMovement[i].x;
            if (imgMatch[i].center.y  < top_height || imgMatch[i].center.y  > maxY)
                cardMovement[i].y = -cardMovement[i].y;
            imgMatch[i].center = CGPointMake(imgMatch[i].center.x+cardMovement[i].x , imgMatch[i].center.y+cardMovement[i].y );
        }
        
    }
}

- (void) playActivityHelp
{
    if (iHelpVoice==1)
    {
        [self stopSound];
        activityHelpSoundName = @"activity_instruction";
        activityHelpSoundFile = [[NSBundle mainBundle] pathForResource:activityHelpSoundName ofType:@"wav"];
        activityHelpSoundURL = [NSURL fileURLWithPath:activityHelpSoundFile];
        AudioServicesCreateSystemSoundID((CFURLRef)activityHelpSoundURL, &activityHelpSound);
        AudioServicesPlaySystemSound(activityHelpSound);
    }
    
}

/************************************************************/
/******************* R E S U L T S **************************/
/************************************************************/


- (void) openviewResults
{
    [ImageCache releaseCache];
    
    [self.view addSubview:viewResults] ;
    viewResults.multipleTouchEnabled=NO;
    viewResults.exclusiveTouch=YES;
    
    if (iResultsSound==1)
    {
        [self stopSound];
        resultsSoundName = @"well_done";
        resultsSoundFile = [[NSBundle mainBundle] pathForResource:resultsSoundName ofType:@"wav"];
        resultsSoundURL = [NSURL fileURLWithPath:resultsSoundFile];
        AudioServicesCreateSystemSoundID((CFURLRef)resultsSoundURL, &resultsSound);
        AudioServicesPlaySystemSound(resultsSound);
    }
    game_status.text = @"Results";
    NSString *scoreString = [NSString stringWithFormat:@"Well done %@", user_name.text];
    result_message1.text = scoreString;
    NSString *timeString = [NSString stringWithFormat:@"%d\n%@ mins, %@ secs", level,activity_mins.text,activity_secs.text];
    result_message2.text = timeString;
    timeString = [NSString stringWithFormat:@"%d mins, %d secs ",max_score/60,max_score%60];
    result_message3.text = timeString;
    [self addScore:[self getDBPath]];
    
}

- (void) closeResults
{
    for (UIView *subview in [viewActivity subviews]) {
        // Only remove the subviews with tag > 100 lights and card images
        if (subview.tag >= 100) {
            [subview removeFromSuperview];
        }
    }
    for (UIView *subview in [ imgTarget subviews]) {
        // Only remove the subviews with tag > 100 lights and card images
        if (subview.tag >= 100) {
            [subview removeFromSuperview];
        }
    }
    for (UIView *subview in [ imgDist1 subviews]) {
        // Only remove the subviews with tag > 100 lights and card images
        if (subview.tag >= 100) {
            [subview removeFromSuperview];
        }
    }    [viewResults removeFromSuperview];
    [viewActivity removeFromSuperview];
    [viewBackground removeFromSuperview];
    game_status.text = @"Home";
    startSecs=0;
    startMins=0;
    currentSecs=0;
    currentMins=0;
    iButtonPressed=0;
}



- (void) closeviewResults
{
    [self closeResults];
}

-(void) addScore:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    
    NSDate *today=[NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString=[dateFormat stringFromDate:today];
    [dateFormat release];
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        const char *querySQL = "INSERT INTO Scores (user_id,score_date,score,secs_taken,level,comb_id) VALUES(?,?,?,?,?,?)";
        if (sqlite3_prepare_v2(matchDB, querySQL, -1, &statement, NULL) != SQLITE_OK)
        {       /* Add some error code*/
        }
        sqlite3_bind_int(statement,1,user_id);
        sqlite3_bind_text(statement,2,[dateString UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_int(statement,3,score);
        sqlite3_bind_int(statement,4,(currentMins*60)+currentSecs);
        sqlite3_bind_int(statement,5,level);
        sqlite3_bind_int(statement,6,rand_comb);
        /*  sqlite_step(statement);*/
        if (sqlite3_step(statement) == SQLITE_ERROR)
        {
            NSLog(@"Error: failed to  update score '%@'.", sqlite3_errmsg(matchDB));
        }
        sqlite3_finalize(statement);
        sqlite3_close(matchDB);
    }
    if (max_score == 0)
    {
        [self addTopScore:[self getDBPath]];
        max_score=((currentMins*60)+currentSecs);
    }
    else if (((currentMins*60)+currentSecs) < max_score)
    {
        [self addTopScore:[self getDBPath]];
        max_score = ((currentMins*60)+currentSecs);
    }
    [self deleteOldScores:[self getDBPath]];
    
}


-(void) getTopScore:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    
    max_score = 0;
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        const char *querySQL = "SELECT minSecs from TopScores WHERE userid = ? and level=?";
        if (sqlite3_prepare_v2(matchDB, querySQL, -1, &statement, NULL) != SQLITE_OK)
        {       /* Add some error code*/
        }
        sqlite3_bind_int(statement,1,user_id);
        sqlite3_bind_int(statement,2,level);
        
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            max_score =  sqlite3_column_int(statement, 0);
        }
        sqlite3_finalize(statement);
        
        sqlite3_close(matchDB);
    }
    
}

-(void) addTopScore:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        const char *querySQL = "DELETE FROM TopScores WHERE userid=? and level=?;";
        if (sqlite3_prepare_v2(matchDB, querySQL, -1, &statement, NULL) != SQLITE_OK)
        {       /* Add some error code*/
        }
        sqlite3_bind_int(statement,1,user_id);
        sqlite3_bind_int(statement,2,level);
        if (sqlite3_step(statement) == SQLITE_ERROR)
        {
            NSLog(@"Error: failed to  delete top score '%@'.", sqlite3_errmsg(matchDB));
        }
        sqlite3_finalize(statement);
        querySQL = "INSERT INTO TopScores (userid,level,minSecs) VALUES(?,?,?)";
        if (sqlite3_prepare_v2(matchDB, querySQL, -1, &statement, NULL) != SQLITE_OK)
        {       /* Add some error code*/
        }
        sqlite3_bind_int(statement,1,user_id);
        sqlite3_bind_int(statement,2,level);
        sqlite3_bind_int(statement,3,(currentMins*60)+currentSecs);
        if (sqlite3_step(statement) == SQLITE_ERROR)
        {
            NSLog(@"Error: failed to  insert top score '%@'.", sqlite3_errmsg(matchDB));
        }
        sqlite3_finalize(statement);
        sqlite3_close(matchDB);
    }
    
}

-(void) deleteOldScores:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        const char *querySQL = "DELETE FROM Scores WHERE user_id=? and level=? and rowid not in (SELECT rowid FROM Scores WHERE user_id=? and level=? ORDER BY rowid DESC LIMIT 10 );";
        if (sqlite3_prepare_v2(matchDB, querySQL, -1, &statement, NULL) != SQLITE_OK)
        {       /* Add some error code*/
        }
        sqlite3_bind_int(statement,1,user_id);
        sqlite3_bind_int(statement,2,level);
        sqlite3_bind_int(statement,3,user_id);
        sqlite3_bind_int(statement,4,level);
        if (sqlite3_step(statement) == SQLITE_ERROR)
        {
            NSLog(@"Error: failed to  old scores '%@'.", sqlite3_errmsg(matchDB));
        }
        sqlite3_finalize(statement);
        sqlite3_close(matchDB);
    }
    
}


/************************************************************/
/******************* 3. H E L P ********************************/
/************************************************************/

- (void) openviewHelp
{
    if (iButtonPressed!= 1)
    {
        iButtonPressed=1;
        if (play_status == 0)
        {
            [self.view addSubview:viewBackground] ;
            [self.view addSubview:viewHelp] ;
            viewHelp.multipleTouchEnabled=NO;
            viewHelp.exclusiveTouch=YES;
            
            game_status.text = @"Help & Info";
        }
        helpNo = 0;
        [self showHelpOverview];
    }
}


- (void) showHelpOverview
{
    NSString *helpText1;
    
    switch (helpNo){
        case 0:
        {
            helpText1 = @"Match IT activities help survivors of stroke and brain injury to develop key\nskills while they interact with friends and family.\n\nThere are several versions of Match IT, in Match IT Food Words:\n   •	The aim is to drag the smaller word cards onto the matching large\n        word and picture cards in the shortest possible time. \n  •	The cards are neither semantically nor phonologically related \n  •	One card is always an item of food the other cards are\n        everyday objetcs.\n\nSkills - this activity may help to develop: \n  •	Visual processing skills such as scanning and word analysis\n  •	Problem solving skills \n  •	Executive functions\n  •	Attention skills\n  •	Language skills";
            helpText.text = helpText1;
            helpTitle.text = @"Match IT Food Activity - Description";
        }
    }
}

- (void) showHelpInstructions
{
    NSString *helpText1;
    
    switch (helpNo){
        case 0:
        {
            helpText1 = @"1. You will see two large word and picture cards at the top of the screen.\n\n2. You will also see a range of smaller word cards on the rest of the screen.\n\n3. The aim is to drag the smaller word cards onto the matching large word and picture\n    cards in the shortest possible time.\n\n4. When you have made a match the smaller picture card will disappear. \n\n5. Unmatched picture cards will return to their original position. \n\n6. When you have made all the possible matches, another set of word cards\n    will appear.\n\n7. A total of 12 matching word cards will appear during each activity. \n\n";
            helpText.text = helpText1;
            helpTitle.text = @"Match IT Food Activity -  Instructions";
        }
    }
}


- (void) showHelpFeedback
{
    NSString *helpText1;
    
    helpText1 = @"1. A total of 12 matching word cards will appear during each activity.\n\n2. As you progress through the levels we introduce non-matching words.\n Your name is on the top left. Your score is in the top middle.\n    The time you have taken to complete the level appears on the top right\n    You can see which level you’re playing on the bottom right.\n\n4. You can see your progress over the last 10 times you completed each level\n    by hitting the ‘Analytics’ button on the bottom of the ‘Home’ screen.\n\n5. The lights on the top left allow you to track your progress in each level. \n\n6. Match IT provides constant encouragement by naming each picture card\n    that you match correctly. You will also hear and see positive feedback when\n    you have reached the end of each level.";
    helpText.text = helpText1;
    helpTitle.text = @"Match IT Food Activity - Scoring & Feedback";
}

- (void) showHelpLevels
{
    NSString *helpText1;
    
    helpText1 = @"LEVEL 1\nYou will see 4 smaller word cards; all of these match the large word and picture cards at the top of the screen.  You can complete 3 rounds of 4 matches.\n\nLEVEL 2\nYou will see 6 smaller word cards, 4 of these match the large word and picture cards and there are 2 distracting words.  You can complete 3 rounds of 4 matches.\n\nLEVEL 3\nYou will see 9 word cards, 6 of these match the large word and picture cards and there are 3 distracting words.  You can complete 2 rounds of 6 matches.\n\nLEVELS 4-6\nThese levels mirror levels 1-3 but they include slow movement.\n\nLEVELS 7-9\nThese levels mirrror levels 1-3 but they include fast movement.";
    helpText.text = helpText1;
    helpTitle.text = @"Match IT Food Activity - Levels Explained";
}

- (void) showHelpTherapy
{
    NSString *helpText1;
    
    helpText1 = @"Match IT encourages interaction between friends and family members.\n\nMatch IT is primarily a visual processing and executive functioning task.\n\nMatch IT challenges you to use your visual processing skills of \n    1.	Scanning \n    2.	Analyzing similarities and differences\n    3.	Identifying the important features of a word\n\nMatch IT also challenges you to use your executive functions of\n     1. Problem solving \n     2. Revising and devising strategies \n     3. Reflecting on performance in real time \n\nThese skills are often lost or impaired following brain injury which can have an impact on every day activities, communications and social interaction and family life.\n\n ";
    helpText.text = helpText1;
    helpTitle.text = @"Match IT Food Activity - Therapeutic Benefit";
}

- (void) showHelpGlossary
{
    NSString *helpText1;
    
    helpText1 = @"'SEMANTIC'\nThe meaning of a word.\n\n'SEMANTICALLY RELATED WORDS'\nWords that come from the same semantic category. E.g. two food items such as an 'apple' and an 'egg'.\n\n'PHONOLOGICAL'\nThe sound of a word.\n\n'PHONOLOGICALLY RELATED WORDS'\nWords that sound the same. E.g. two items starting with the same sound such as ‘car’ and ‘cake’.\n\n'DISTRACTORS' \nPWords that do not match the target words.  These words are introduced to increase the level of difficulty by creating a distraction.";
    helpText.text = helpText1;
    helpTitle.text = @"Match IT Food Activity - Glossary of Terms";
}


- (void) closeviewHelp
{
    [viewHelp removeFromSuperview];
    [viewBackground removeFromSuperview];
    game_status.text = @"Home";
    iButtonPressed = 0;
}

/************************************************************/
/******************* 4. A N A L Y T I C S  ***********************/
/************************************************************/


- (void) openviewAnalytics
{
    if (iButtonPressed!= 1)
    {
        iButtonPressed=1;
        if (play_status == 0)
        {
            [self.view addSubview:viewBackground] ;
            [self.view addSubview:viewAnalytics] ;
            viewAnalytics.multipleTouchEnabled=NO;
            viewAnalytics.exclusiveTouch=YES;
            
            [self.graphControl setNeedsDisplay];
            game_status.text = @"User Statistics & Analytics";
            NSString *scoreString = [NSString stringWithFormat:@"Match IT Analytics for %@", user_name.text];
            analytics_title.text = scoreString;
        }
    }
}

- (void) closeviewAnalytics
{
    [viewAnalytics removeFromSuperview];
    [viewBackground removeFromSuperview];
    game_status.text = @"Home";
    iButtonPressed=0;
}



-(void) updateCurrentSeries123
{
    NSInteger s1 = 1;
    NSInteger s2 = 2;
    NSInteger s3 = 3;
    
    [self updateCurrentSeries:[self getDBPath] :s1 :s2 :s3];
    
}

- (void) updateCurrentSeries456
{
    NSInteger s1 = 4;
    NSInteger s2 = 5;
    NSInteger s3 = 6;
    
    [self updateCurrentSeries:[self getDBPath] :s1 :s2 :s3];
}


-(void) updateCurrentSeries:(NSString *)dbPath :(NSInteger)s1 :(NSInteger)s2 :(NSInteger)s3;
{
    sqlite3_stmt    *statement;
    
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        const char *querySQL = "UPDATE Users set analytics_series1=?,analytics_series2=?,analytics_series3=? where user_id=(select user_id from CurrentSettings)";
        
        if (sqlite3_prepare_v2(matchDB, querySQL, -1, &statement, NULL) != SQLITE_DONE)
        {//add error handling
            sqlite3_bind_int(statement,1,s1);
            sqlite3_bind_int(statement,2,s2);
            sqlite3_bind_int(statement,3,s3);
            
        }
        if (sqlite3_step(statement) != SQLITE_DONE)
        {
            NSLog(@"Error: failed to run series update statement with message '%@'.", sqlite3_errmsg(matchDB));
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(matchDB);
    }
    [self.graphControl setNeedsDisplay];
    
}

-(void) updateCurrentSeries789
{
    NSInteger s1 = 7;
    NSInteger s2 = 8;
    NSInteger s3 = 9;
    
    [self updateCurrentSeries:[self getDBPath] :s1 :s2 :s3];
}

-(void) updateCurrentUser:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        const char *querySQL = "UPDATE CurrentSettings set user_id=?";
        
        if (sqlite3_prepare_v2(matchDB, querySQL, -1, &statement, NULL) != SQLITE_DONE)
        {//add error handling
        }
        sqlite3_bind_int(statement,1,user_id);
        if (sqlite3_step(statement) != SQLITE_DONE)
        {
            NSLog(@"Error: failed to run update current user statement with message '%@'.", sqlite3_errmsg(matchDB));
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(matchDB);
    }
    
}

- (void) playAnalyticsHelp
{
    if (iHelpVoice==1)
    {
        [self stopSound];
        activityHelpSoundName = @"analytics_instruction";
        activityHelpSoundFile = [[NSBundle mainBundle] pathForResource:activityHelpSoundName ofType:@"wav"];
        activityHelpSoundURL = [NSURL fileURLWithPath:activityHelpSoundFile];
        AudioServicesCreateSystemSoundID((CFURLRef)activityHelpSoundURL, &activityHelpSound);
        AudioServicesPlaySystemSound(activityHelpSound);
    }
    
}
/*************** END ANALYTICS ****************/

-(void) getObjects:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    NSString *querySQL;
    
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        if (base_level==1)
        {
            rand_comb = (arc4random()%85)+1 ;
            querySQL = [NSString stringWithFormat: @"SELECT target_name,distractor_name FROM Combinations1 where rowid =\"%d\"", rand_comb];
        }
        else
        {
            rand_comb = (arc4random()%550)+1 ;
            querySQL = [NSString stringWithFormat: @"SELECT target_name,distractor_name1,distractor_name2 FROM Combinations2 where rowid =\"%d\"", rand_comb];
        }
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(matchDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                targetName1 =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                
                dist1Name1 =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                if (base_level==0 || base_level == 2)
                {
                    dist2Name1 =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                }
                status.text = @"Match found";
            }
            else
            {
                status.text = @"Match not found";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(matchDB);
    }
}


-(void) timerSetKeyHighlight:(NSTimer *)timer {
	UIButton *btnHigh = (UIButton *)[timer userInfo];
	btnHigh.highlighted = YES;
	btnHigh.enabled = YES;
}

/*******************************************************/
/*************** 4. S E T T I N G S     *******************/
/*******************************************************/


- (void) openviewSettings
{
    if (iButtonPressed!= 1)
    {
        iButtonPressed=1;
        if (play_status == 0)
        {
            [self.view addSubview:viewBackground] ;
            [self.view addSubview:viewSettings] ;
            /*viewSettings.multipleTouchEnabled=NO;
            viewSettings.exclusiveTouch=YES;*/
            
            game_status.text = @"User Settings";
            [self getUserNames:[self getDBPath]];
            switch (user_id){
                case 1:
                    [self setUser1];
                    break;
                case 2:
                    [self setUser2];
                    break;
                case 3:
                    [self setUser3];
                    break;
                case 4:
                    [self setUser4];
                    break;
                default:
                    [self setUser1];
                    break;
            }
        }
    }
}

-(void) getUserNames:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    NSString *users[4];
    
    users[0]=@"User1";
    users[1]=@"User2";
    users[2]=@"User3";
    users[3]=@"User4";
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT first_name from users order by user_id"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(matchDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSInteger i =0;
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                users[i] =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                i++;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(matchDB);
    }
    [btnUser1 setTitle:users[0] forState:UIControlStateNormal];
    [btnUser2 setTitle:users[1] forState:UIControlStateNormal];
    [btnUser3 setTitle:users[2] forState:UIControlStateNormal];
    [btnUser4 setTitle:users[3] forState:UIControlStateNormal];
    
}


- (void) closeviewSettings
{
    [self updateUser:[self getDBPath]];
    [self updateCurrentUser:[self getDBPath]];
    [self setUser];
    [viewSettings removeFromSuperview];
    [viewBackground removeFromSuperview];
    game_status.text = @"Home";
    iButtonPressed=0;
    
}



- (void) clearUsers
{
    if (user_mode == 1)
    {
        /*[userTimer invalidate];*/
        userTimer=nil;
        btnUser1.highlighted = NO;
        btnUser2.highlighted = NO;
        btnUser3.highlighted = NO;
        btnUser4.highlighted = NO;
    }
}
- (void) saveSettings
{
    [self updateUser:[self getDBPath]];
}


- (void) setUser1
{
    [self updateUser:[self getDBPath]];
    user_id=1;
    [self clearUsers];
    [userTimer release];
    userTimer = [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(timerSetKeyHighlight:) userInfo:btnUser1 repeats:NO];
    [self setUser];
}

- (void) setUser2
{
    [self updateUser:[self getDBPath]];
    user_id=2;
    [self clearUsers];
    [userTimer release];
    userTimer =  [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(timerSetKeyHighlight:) userInfo:btnUser2 repeats:NO];
    [self setUser];
}

- (void) setUser3
{
    [self updateUser:[self getDBPath]];
    user_id=3;
    [self clearUsers];
    [userTimer release];
    userTimer = [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(timerSetKeyHighlight:) userInfo:btnUser3 repeats:NO];
    [self setUser];
}

- (void) setUser4
{
    [self updateUser:[self getDBPath]];
    user_id=4;
    [self clearUsers];
    [userTimer release];
    userTimer = [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(timerSetKeyHighlight:) userInfo:btnUser4 repeats:NO];
    [self setUser];
}

- (void) setUser
{
    [self getUser:[self getDBPath]];
    user_name.text = first_name.text;
    user_mode = 1;
}


-(void) getCurrentUser:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT user_id from CurrentSettings"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(matchDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                user_id = sqlite3_column_int(statement, 0);
                
            } else {
                status.text = @"Match not found";
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(matchDB);
    }
    
}



-(void) getUser:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT first_name, last_name, match_sound,help_sound,results_sound from users where user_id =\"%d\"",user_id];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(matchDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                first_name.text =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                char *local_last_name = sqlite3_column_text(statement, 1);
                if (local_last_name == NULL)
                    last_name.text  = nil;
                else
                    last_name.text =  [NSString stringWithUTF8String:local_last_name];
                iMatchSound = sqlite3_column_int(statement, 2);
                iHelpVoice = sqlite3_column_int(statement, 3);
                iResultsSound = sqlite3_column_int(statement, 4);
                
            } else {
                
                game_status.text = @"User not found";
                /*       first_name.text =  NULL;
                 last_name.text =  NULL;*/
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(matchDB);
    }
    if (iMatchSound == 1)
        [swMatchSound setOn:YES];
    else
        [swMatchSound setOn:NO];
    if (iResultsSound == 1)
        [swResultsSound setOn:YES];
    else
        [swResultsSound setOn:NO];
    if (iHelpVoice == 1)
        [swHelpVoice setOn:YES];
    else
        [swHelpVoice setOn:NO];
}





-(void) updateUser:(NSString *)dbPath
{
    sqlite3_stmt    *statement;
    
    NSString *fname  = [first_name.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    if (fname.length == 0)
    {
        first_name.text=[NSString stringWithFormat: @"User %d",user_id];
    }
    
    if (sqlite3_open([dbPath UTF8String], &matchDB) == SQLITE_OK)
    {
        const char *querySQL = "UPDATE Users set first_name=?,last_name=?,match_sound=?,help_sound=?,results_sound=? where user_id = ?";
        
        if (sqlite3_prepare_v2(matchDB, querySQL, -1, &statement, NULL) != SQLITE_DONE)
        {//add error handling
        }
        sqlite3_bind_text(statement,1,[first_name.text UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,2,[last_name.text UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_int(statement,3,iMatchSound);
        sqlite3_bind_int(statement,4,iHelpVoice);
        sqlite3_bind_int(statement,5,iResultsSound);
        sqlite3_bind_int(statement,6,user_id);
        if (sqlite3_step(statement) != SQLITE_DONE)
        {
            NSLog(@"Error: failed to run update statement with message '%%@.", sqlite3_errmsg(matchDB));
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(matchDB);
    }
    [self getUserNames:[self getDBPath]];
    
}

- (void) playSettingsHelp
{
    if (iHelpVoice==1)
    {
        [self stopSound];
        activityHelpSoundName = @"settings_instruction";
        activityHelpSoundFile = [[NSBundle mainBundle] pathForResource:activityHelpSoundName ofType:@"wav"];
        activityHelpSoundURL = [NSURL fileURLWithPath:activityHelpSoundFile];
        AudioServicesCreateSystemSoundID((CFURLRef)activityHelpSoundURL, &activityHelpSound);
        AudioServicesPlaySystemSound(activityHelpSound);
    }
    
}
/******** END SETTINGS  ****************************/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||  (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.first_name = nil;
    self.last_name = nil;
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (void) copyDatabaseIfNeeded {
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    /*   if(success || !success) {
     
     [[NSFileManager defaultManager] removeItemAtPath:dbPath error:NULL];*/
    if (!success){
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"MatchIt.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
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




@end

