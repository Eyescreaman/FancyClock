//
//  ViewController.m
//  MyFancyClock
//
//  Created by angelflame on 14/5/18.
//  Copyright (c) 2014年 angelflame. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *mdata;

}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //get plist
    [self getPlist:@"ClockPlist" withDataArray:&mdata];
    
    NSMutableArray *mdataName;
    mdataName = [[NSMutableArray alloc]init];
    for(int i=0; i<mdata.count ; i++)
        [mdataName insertObject:[[mdata objectAtIndex:i] objectForKey:@"imagename"] atIndex:i];
    
    //How to use
    mFancyClockView = [[MyFancyClockView alloc] initWithFrame:CGRectMake(20.0f,100.0f, 280.0f,280.0f )];
    
    [mFancyClockView initWithImageNameArray:mdataName];
    
    [mFancyClockView startClockAnimation];
    
    [self.view addSubview:mFancyClockView];
}


- (void) getPlist:(NSString*)filename withDataArray:(NSMutableArray * __strong *)dataarray
{
    @try {
        
        
        NSString *plistfileName = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
        
        *dataarray = [[NSMutableArray alloc] initWithContentsOfFile:plistfileName];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception: %@",exception);
        
    }
    @finally {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
