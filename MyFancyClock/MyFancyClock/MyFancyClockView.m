//
//  MyFancyClockView.m
//  TrainingTest
//
//  Created by angelflame on 14/5/9.
//  Copyright (c) 2014年 angelflame. All rights reserved.
//

#import "MyFancyClockView.h"
#define  hourdifference    M_PI/6.0
#define  minutedifference  M_PI/360.0
#define  minutedegree      M_PI/30.0
#define  msecondsdegree     M_PI/30.0
@implementation MyFancyClockView
{
    NSTimer        *mClockTimer;
    
    NSMutableArray *mimageViewArray;
    
    NSMutableArray *mimageArray;
    
    NSMutableArray *mcoverimageArray;
    
    CGRect          mbounds;
    
    CGFloat         mradius;
    
    CGPoint         mCenter;
    
    CGFloat         mitemradius;
    
    CGFloat         mCurrentHour;
    
    CGFloat         mCurrentMinutes;
    
    CGFloat         mCurrentSeconds;
    
    CGFloat         mdegrees;
    
    CGFloat         mconstantDegree;
    
    NSInteger       currentHourIndex;
    
    NSInteger       currentSecondIndex;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        mradius       = [self getRadius:self.bounds];
        
        mitemradius   = [self getItemRadius:mradius];
        
        [self getCurrenTime];
        
        mCenter = CGPointMake(self.bounds.size.width/2.0f , self.bounds.size.height/2.0f );
        
        self.clipsToBounds = YES;
        
        mimageViewArray  = [[NSMutableArray alloc]init];
        mimageArray      = [[NSMutableArray alloc]init];
        mcoverimageArray = [[NSMutableArray alloc]init];
        
        mdegrees        = 0.0f;
        mconstantDegree = 1.5*M_PI;
        
        
        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"clockbackground.jpeg"]];
        
        self.backgroundColor    =  background;
        
        self.layer.cornerRadius =  mradius + 30.0f;
 
        self.clipsToBounds      =  YES;
        
    }
    return self;
}

-(CGFloat)getRadius:(CGRect)bounds
{
    CGFloat radius = 0.0f;
    
    if(bounds.size.height>=bounds.size.width)
     radius = bounds.size.width/2.0f -30.0f;
    else
     radius = bounds.size.height/2.0f -30.0f;
    
    return radius;
}


-(CGFloat)getItemRadius:(CGFloat)radius
{
    CGFloat m = M_PI*radius/6.0f;
    
    CGFloat r = m/4.0;
    
    return r;
}


-(void)getCurrenTime
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                              initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *components =
    [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    
    mCurrentHour    = [components hour]%12;
    mCurrentMinutes = [components minute];
    mCurrentSeconds = [components second];
}

-(void)initWithImageNameArray:(NSMutableArray*)mImageName
{
    
    //set 12 image
    for(int i=0; i< mImageName.count ; i++)
    {
        //set up the 12 point image
        UIImage     *img = [UIImage imageNamed:[mImageName objectAtIndex:i ]];
        UIImageView *mphoto = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f,0.0f , 2*mitemradius,2*mitemradius) ];
        mphoto.contentMode = UIViewContentModeScaleAspectFill;
        mphoto.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin
        |UIViewAutoresizingFlexibleLeftMargin;

        [mphoto setImage:img];
        mphoto.layer.cornerRadius = mitemradius;
        
        if(mCurrentHour ==i)
            mphoto.transform = CGAffineTransformMakeScale(1.50f, 1.50f);
        
        mphoto.layer.masksToBounds = YES;
        mphoto.clipsToBounds = YES;
        
        mdegrees = (2 * i * M_PI / mImageName.count)+1.5*M_PI;
        
        if(mdegrees>=2*M_PI)
            mdegrees = mdegrees - 2*M_PI;
        
        mphoto.center = CGPointMake(mCenter.x + mradius * cosf(mdegrees),mCenter.y + mradius * sinf(mdegrees));
        
        
        //set up the 12 point cover image
        UIImageView *mcoverphoto = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f,0.0f , 2*mitemradius,2*mitemradius) ];
        mcoverphoto.layer.cornerRadius = mitemradius;
        
        mcoverphoto.contentMode = UIViewContentModeScaleAspectFill;
        mcoverphoto.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin
        |UIViewAutoresizingFlexibleLeftMargin;

        
        mcoverphoto.backgroundColor    = [UIColor blackColor];
        mcoverphoto.alpha              =  0.8;
        
        if(mCurrentHour ==i)
        {
          mcoverphoto.transform = CGAffineTransformMakeScale(1.50f, 1.50f);
          mcoverphoto.alpha     = 0.0;
        }
        
        mcoverphoto.layer.masksToBounds = YES;
        mcoverphoto.clipsToBounds = YES;
        
        mdegrees = (2 * i * M_PI / mImageName.count)+1.5*M_PI;
        
        if(mdegrees>=2*M_PI)
            mdegrees = mdegrees - 2*M_PI;
        
        mcoverphoto.center = CGPointMake(mCenter.x + mradius * cosf(mdegrees),mCenter.y + mradius * sinf(mdegrees));
        
        
        
        [mcoverimageArray addObject:mcoverphoto];
        [mimageArray      addObject:img];
        [mimageViewArray  addObject:mphoto];
        [self addSubview: mphoto];
        [self addSubview: mcoverphoto];
       
    }
    
    //set center image
    UIImage     *img = [mimageArray objectAtIndex:mCurrentHour];
    self.mCenterView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f,0.0f , 2*(mradius - mitemradius - 20.0f),2*(mradius - mitemradius - 20.0f)) ];
    [self.mCenterView setImage:img];
    self.mCenterView.layer.cornerRadius = mradius - mitemradius - 20.0f;
    self.mCenterView.layer.masksToBounds = YES;
    self.mCenterView.clipsToBounds  = YES;
    self.mCenterView.center = CGPointMake(mCenter.x,mCenter.y);
    [self addSubview: self.mCenterView];

    
    //init the time component like hour hand..etc
    [self setUpTime];
}

-(void)setUpTime
{
    //set the hour hand , minute hand , second hand
    self.mHourhandView   = [[UIView alloc] initWithFrame:CGRectMake(mCenter.x,mCenter.y,mradius/2.4 , 8.0f)];
    self.mMinutehandView = [[UIView alloc] initWithFrame:CGRectMake(mCenter.x,mCenter.y,mradius/1.8 , 5.0f)];
    self.mSecondhandView = [[UIView alloc] initWithFrame:CGRectMake(mCenter.x,mCenter.y,mradius/1.4 , 2.5f)];
    
    
    [self.mHourhandView.layer   setAnchorPoint:CGPointMake(0.0, 0.5)];
    [self.mMinutehandView.layer setAnchorPoint:CGPointMake(0.0, 0.5)];
    [self.mSecondhandView.layer setAnchorPoint:CGPointMake(0.0, 0.5)];
    
    //# important
    self.mHourhandView.center    =CGPointMake(mCenter.x, mCenter.y);
    self.mMinutehandView.center  =CGPointMake(mCenter.x, mCenter.y);
    self.mSecondhandView.center  =CGPointMake(mCenter.x, mCenter.y);
    
    self.mHourhandView.backgroundColor   =  [UIColor colorWithRed:0.1 green:0.68 blue:1.0 alpha:0.6];

    self.mMinutehandView.backgroundColor =  [UIColor colorWithRed:1.0 green:0.71 blue:0.85 alpha:0.6];

    self.mSecondhandView.backgroundColor =  [UIColor whiteColor];
    
    //init set hour hand
    CGFloat thourdegree = mconstantDegree + mCurrentHour*hourdifference + minutedifference*mCurrentMinutes;
    
    if(thourdegree>=2*M_PI)
        thourdegree = thourdegree - 2*M_PI;
    
    
    [self.mHourhandView.layer setTransform:CATransform3DMakeRotation(thourdegree, 0, 0, 1)];
    
    currentHourIndex = mCurrentHour;
    
    //init set minute hand
    CGFloat tminutedegree = mconstantDegree + minutedegree*mCurrentMinutes;
    
    if(tminutedegree>=2*M_PI)
        tminutedegree = tminutedegree - 2*M_PI;
    
    
    [self.mMinutehandView.layer setTransform:CATransform3DMakeRotation(tminutedegree, 0, 0, 1)];
    
    //init set second hand
    CGFloat tsecondsdegree = mconstantDegree + msecondsdegree*mCurrentSeconds;
    
    if(tsecondsdegree>=2*M_PI)
        tsecondsdegree = tsecondsdegree - 2*M_PI;
    
    [self.mSecondhandView.layer setTransform:CATransform3DMakeRotation(tsecondsdegree, 0, 0, 1)];
    
    [self addSubview: self.mHourhandView];
    [self addSubview: self.mMinutehandView];
    [self addSubview: self.mSecondhandView];
    
    
    //set up center coner
     UIImageView *mconerimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f,0.0f , 2*mitemradius/2.0,2*mitemradius/2.0) ];
    mconerimageview.contentMode = UIViewContentModeScaleAspectFill;
    mconerimageview.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin
    |UIViewAutoresizingFlexibleLeftMargin;
    mconerimageview.center = CGPointMake(mCenter.x ,mCenter.y);
    mconerimageview.backgroundColor = [UIColor colorWithRed:1.0 green:0.677 blue:0.07 alpha:0.8];
    mconerimageview.layer.cornerRadius = mitemradius/2.0;
    mconerimageview.layer.masksToBounds = YES;
    mconerimageview.clipsToBounds = YES;
    [self addSubview: mconerimageview];
}


-(void)ClockAnimation
{
    [self getCurrenTime];
    
    
    //
    NSInteger curringbrightindex = mCurrentSeconds/5.0f;
    if(curringbrightindex>=12)
        curringbrightindex = 0;
    
   
    
       //init set second hand
    CGFloat tsecondsdegree = mconstantDegree + msecondsdegree*mCurrentSeconds;
    
    if(tsecondsdegree>=2*M_PI)
        tsecondsdegree = tsecondsdegree - 2*M_PI;
    
    
    //init set minute hand
    CGFloat tminutedegree = mconstantDegree + minutedegree*mCurrentMinutes;
    
    if(tminutedegree>=2*M_PI)
        tminutedegree = tminutedegree - 2*M_PI;
    
    
    //init set hour hand
    CGFloat thourdegree = mconstantDegree + mCurrentHour*hourdifference + minutedifference*mCurrentMinutes;
    
    if(thourdegree>=2*M_PI)
        thourdegree = thourdegree - 2*M_PI;
    
    
    
    
    [UIView transitionWithView:self.mSecondhandView duration:0.1 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.mSecondhandView.layer setTransform:CATransform3DMakeRotation(tsecondsdegree, 0, 0, 1)];
    }completion:^(BOOL finished)
     {
         
         UIImageView *simg  = [mcoverimageArray objectAtIndex:curringbrightindex];
         simg.alpha  = 0.0;
         
         NSInteger mi = curringbrightindex - 1;
         if(mi<0)
            mi = 11;
         
          if(mi!=currentHourIndex)
          {
            UIImageView *simg2 = [mcoverimageArray objectAtIndex:mi];
            simg2.alpha = 0.6;
          }
      }];
    
    [UIView transitionWithView:self.mMinutehandView duration:0.1 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.mMinutehandView.layer setTransform:CATransform3DMakeRotation(tminutedegree, 0, 0, 1)];
    }completion:^(BOOL finished)
     {
         
         
     }];

    
    [UIView transitionWithView:self.mHourhandView duration:0.1 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.mHourhandView.layer setTransform:CATransform3DMakeRotation(thourdegree, 0, 0, 1)];
    }completion:^(BOOL finished)
     {
         if(currentHourIndex!=mCurrentHour)
         {
             
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.4];
             
            UIImage     *img = [mimageArray objectAtIndex:mCurrentHour];
            [self.mCenterView setImage:img];

            UIImageView *mcphoto = [mimageViewArray  objectAtIndex:mCurrentHour];
            UIImageView *mccover = [mcoverimageArray objectAtIndex:mCurrentHour];
            mcphoto.transform = CGAffineTransformMakeScale(1.50f, 1.50f);
            mccover.transform = CGAffineTransformMakeScale(1.50f, 1.50f);
             
            UIImageView *mlphoto = [mimageViewArray objectAtIndex:currentHourIndex];
            UIImageView *mlcover = [mcoverimageArray objectAtIndex:currentHourIndex];
            mlphoto.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            mlcover.transform = CGAffineTransformMakeScale(1.0f, 1.0f);

             
            [UIView commitAnimations];

            currentHourIndex = mCurrentHour;
         }
         
     }];


    
    
}



-(void)startClockAnimation
{
    mClockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ClockAnimation) userInfo:nil repeats:YES];
    
   
    

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
