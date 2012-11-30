//
//  ViewController.h
//  MatchITFoodWords
//
//  Created by Catherine Sweeney on 19/11/2012.
//  Copyright (c) 2012 Catherine Sweeney. All rights reserved.
//



#import <UIKit/UIKit.h>
#include <sqlite3.h>
#import <QuartzCore/CADisplayLink.h>
#import <QuartzCore/QuartzCore.h>
#include <AudioToolbox/AudioToolbox.h>
#include "AudioToolbox/AudioToolbox.h"
#import "drawAnalytics.h"

@interface ViewController : UIViewController{
    
    
    drawAnalytics *graphControl;
    
    NSString *targetName1;
    NSString *dist1Name1;
    NSString *dist2Name1;
    
    
    UITextField *first_name;
    UITextField *last_name;
    
    UIButton *btnUser1;
    UIButton *btnUser2;
    UIButton *btnUser3;
    UIButton *btnUser4;
    
    UILabel *activity_mins;
    UILabel *activity_secs;
    UILabel *best_mins;
    UILabel *best_secs;
    
    UILabel *user_score;
    UILabel *user_max_score;
    UILabel *user_name;
    UILabel *user_level;
    UILabel *game_status;
    UILabel *status;
    UILabel *result_message1;
    UILabel *result_message2;
    UILabel *result_message3;
    
    UILabel *analytics_title;
    
    IBOutlet UISwitch *swMatchSound;
    IBOutlet UISwitch *swResultsSound;
    IBOutlet UISwitch *swHelpVoice;
    
    NSInteger iMatchSound,iResultsSound,iHelpVoice;
    
    
    sqlite3 *matchDB;
    
    UIView *viewSettings;
    UIView *viewHelp;
    UIView *viewActivity;
    UIView *viewResults;
    UIView *viewBackground;
    UIView *viewAnalytics;
    
    UITextView *helpText;
    UITextView *helpTitle;
    
    
    UIBarButtonItem *bbarHelp;
    
    UIImageView *imgTarget;
    UIImageView *imgDist1;
    UIImageView *imgDist2;
    
    UIImageView *imgMatch[9];
    UIImageView *imgLights[20];
    
    NSString *green_light;
    NSString *off_light;
    UIImage *glightImage;
    UIImage *olightImage ;
    
    
    NSInteger score;
    NSInteger max_score;
    NSInteger level;
    NSInteger play_status;
    NSInteger match;
    NSInteger max_round;
    NSInteger round_no;
    NSInteger no_matches;
    NSInteger no_objects;
    
    NSInteger sx,sy;  /*start x and y coordinates before moved*/
    NSInteger helpNo;
    NSInteger rand_comb;
    
    
    NSInteger startMins;
    NSInteger startSecs;
    
    NSInteger currentSecs;
    NSInteger currentMins;
    
    NSInteger lastTouchX;
    NSInteger lastTouchY;
    
    
    NSInteger screen_width;
    NSInteger screen_height;
    NSInteger card_width;
    NSInteger card_area_width;
    NSInteger card_height;
    NSInteger no_cards;
    NSInteger match_objects;
    NSInteger base_level;
    NSInteger top_height;
    NSInteger bottom_height;
    NSInteger om; /*object moving*/
    NSInteger user_id;
    NSInteger iButtonPressed;
    NSInteger stopcard;
    NSInteger touchdown;
    
    NSTimer *theTimer;
    NSTimer *theClock;
    
    NSInteger minX;
    NSInteger maxX;
    NSInteger minY;
    NSInteger maxY;
    NSInteger user_mode;
    
    NSString *targetName, *dist1Name, *dist2Name, *matchCards[9], *shuffleCards[9];
    NSTimer *userTimer;
    
    float touchXOffset, touchYOffset;
    
    CGPoint cardMovement[9];
    
    
    NSString *targetSoundFile,*dist1SoundFile, *resultsSoundFile,*resultsSoundName;
    NSURL *targetSoundURL,*dist1SoundURL, *resultsSoundURL;
    SystemSoundID targetSound, dist1Sound, resultsSound;
    NSString  *activityHelpSoundFile,*activityHelpSoundName;
    NSURL *activityHelpSoundURL;
    SystemSoundID activityHelpSound;
    
    NSString *databasePath;
    
    
}
@property (retain, nonatomic) IBOutlet UIButton *btnUser1;
@property (retain, nonatomic) IBOutlet UIButton *btnUser2;
@property (retain, nonatomic) IBOutlet UIButton *btnUser3;
@property (retain, nonatomic) IBOutlet UIButton *btnUser4;


@property (retain, nonatomic) IBOutlet UIImageView *imgTarget;
@property (retain, nonatomic) IBOutlet UIImageView *imgDist1;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *bbarHelp;

@property (retain, nonatomic) IBOutlet drawAnalytics *graphControl;

@property (retain, nonatomic) IBOutlet UISwitch *swMatchSound;
@property (retain, nonatomic) IBOutlet UISwitch *swResultsSound;
@property (retain, nonatomic) IBOutlet UISwitch *swHelpVoice;

@property (retain, nonatomic) IBOutlet UITextView *helpText;
@property (retain, nonatomic) IBOutlet UITextView *helpTitle;
@property (retain, nonatomic) IBOutlet UITextField *first_name;
@property (retain, nonatomic) IBOutlet UITextField *last_name;
@property (retain, nonatomic) IBOutlet UILabel *activity_mins;
@property (retain, nonatomic) IBOutlet UILabel *activity_secs;
@property (retain, nonatomic) IBOutlet UILabel *best_mins;
@property (retain, nonatomic) IBOutlet UILabel *best_secs;
@property (retain, nonatomic) IBOutlet UILabel *user_score;
@property (retain, nonatomic) IBOutlet UILabel *user_max_score;
@property (retain, nonatomic) IBOutlet UILabel *user_name;
@property (retain, nonatomic) IBOutlet UILabel *user_level;
@property (retain, nonatomic) IBOutlet UILabel *game_status;
@property (retain, nonatomic) IBOutlet UILabel *result_message1;
@property (retain, nonatomic) IBOutlet UILabel *result_message2;
@property (retain, nonatomic) IBOutlet UILabel *result_message3;

@property (retain, nonatomic) IBOutlet UILabel *analytics_title;


@property (retain, nonatomic) IBOutlet UIView *viewSettings;
@property (retain, nonatomic) IBOutlet UIView *viewHelp;
@property (retain, nonatomic) IBOutlet UIView *viewResults;
@property (retain, nonatomic) IBOutlet UIView *viewActivity;
@property (retain, nonatomic) IBOutlet UIView *viewBackground;
@property (retain, nonatomic) IBOutlet UIView *viewAnalytics;


- (IBAction) chgMatchSound;
- (IBAction) chgHelpVoice;
- (IBAction) chgResultsSound;

- (IBAction) openviewSettings;

- (IBAction) playActivityHelp;
- (IBAction) playAnalyticsHelp;
- (IBAction) playSettingsHelp;

- (IBAction) pauseActivity;

- (IBAction) openviewHelp;
- (IBAction) showHelpOverview;
- (IBAction) showHelpTherapy;
- (IBAction) showHelpInstructions;
- (IBAction) showHelpFeedback;
- (IBAction) showHelpGlossary;
- (IBAction) showHelpLevels;
- (IBAction) closeviewHelp;

- (IBAction) openviewAnalytics;
- (IBAction) closeviewAnalytics;

- (void) openviewResults;
- (void) closeResults;
- (IBAction) closeviewResults;

- (IBAction) closeviewSettings;
- (IBAction) setUser1;
- (IBAction) setUser2;
- (IBAction) setUser3;
- (IBAction) setUser4;
- (IBAction) saveSettings;
- (void) setUser;
- (void) clearUsers;

- (IBAction) startActivity;
- (IBAction) startLevel1;
- (IBAction) startLevel2;
- (IBAction) startLevel3;
- (IBAction) startLevel4;
- (IBAction) startLevel5;
- (IBAction) startLevel6;
- (IBAction) startLevel7;
- (IBAction) startLevel8;
- (IBAction) startLevel9;
- (IBAction) endActivity;
- (IBAction) endActivityMsg;


- (void) layoutCards;
- (void) matchObject;
- (void) moveCards:(NSTimer *)theTimer;
- (void) timerSetKeyHighlight:(NSTimer *)timer;
- (void) initialiseTimer;
- (void) initialiseClock;
- (void) updateClock:(NSTimer *)theClock;


- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

- (void) getObjects:(NSString *)dbPath;
- (void) getUser:(NSString *)dbPath;
- (void) getUserNames:(NSString *)dbPath;
- (void) getCurrentUser:(NSString *)dbPath;
- (void) addScore:(NSString *)dbPath;
- (void) getTopScore:(NSString *)dbPath;
- (void) addTopScore:(NSString *)dbPath;
- (void) deleteOldScores:(NSString *)dbPath;

- (void) updateUser:(NSString *)dbPath;
- (void) updateCurrentUser:(NSString *)dbPath;

- (IBAction) updateCurrentSeries123;
- (IBAction) updateCurrentSeries456;
- (IBAction) updateCurrentSeries789;
- (void) updateCurrentSeries:(NSString *)dbPath :(NSInteger)s1 :(NSInteger)s1 :(NSInteger)s1;


/*+ (void) finalizeStatements;*/

@end

