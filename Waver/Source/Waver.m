//
//  Waver.m
//  Waver
//
//  Created by kevinzhow on 14/12/14.
//  Copyright (c) 2014年 Catch Inc. All rights reserved.
//

#import "Waver.h"

@interface Waver ()

@property (nonatomic) CGFloat phase;
@property (nonatomic) CGFloat amplitude;
@property (nonatomic) NSMutableArray * waves;

@end

@implementation Waver


- (id)init
{
    if(self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    
    self.waves = [NSMutableArray new];
    
    self.frequency = 1.5f;
    
    self.amplitude = 1.0f;
    self.idleAmplitude = 0.01f;
    
    self.numberOfWaves = 5;
    self.phaseShift = -0.15f;
    self.density = 5.f;
    
    self.waveColor = [UIColor whiteColor];
    self.mainWaveWidth = 2.0f;
    self.decorativeWavesWidth = 1.0f;
}

-(void)setWaverLevelCallback:(void (^)())waverLevelCallback
{
    _waverLevelCallback = waverLevelCallback;
    
    CADisplayLink *displaylink = [CADisplayLink displayLinkWithTarget:_waverLevelCallback selector:@selector(invoke)];
    [displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    for(int i=0; i < self.numberOfWaves; i++)
    {
        CAShapeLayer *waveline = [CAShapeLayer layer];
        waveline.lineCap       = kCALineCapButt;
        waveline.lineJoin      = kCALineJoinRound;
        waveline.strokeColor   = [[UIColor clearColor] CGColor];
        waveline.fillColor     = [[UIColor clearColor] CGColor];
        //        waveline.lineWidth     = chartData.lineWidth;
        [self.layer addSublayer:waveline];
        [self.waves addObject:waveline];
    }
    
}

- (void)setLevel:(CGFloat)level
{
    _level = level;
    self.phase += self.phaseShift;
    self.amplitude = fmax( level, self.idleAmplitude);
    [self updateMeters];
}

- (void)updateMeters
{
    
    CGFloat halfHeight = CGRectGetHeight(self.bounds) / 2.0f;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat mid = width / 2.0f;
    
    for(int i=0; i < self.numberOfWaves; i++) {
        UIGraphicsBeginImageContext(self.frame.size);
        
        UIBezierPath *wavelinePath = [UIBezierPath bezierPath];
        const CGFloat maxAmplitude = halfHeight - 4.0f; // 4 corresponds to twice the stroke width
        
        // Progress is a value between 1.0 and -0.5, determined by the current wave idx, which is used to alter the wave's amplitude.
        CGFloat progress = 1.0f - (CGFloat)i / self.numberOfWaves;
        CGFloat normedAmplitude = (1.5f * progress - 0.5f) * self.amplitude;
        
        CGFloat multiplier = MIN(1.0, (progress / 3.0f * 2.0f) + (1.0f / 3.0f));
        
        for(CGFloat x = 0; x<width + self.density; x += self.density) {
            
            // We use a parable to scale the sinus wave, that has its peak in the middle of the view.
            CGFloat scaling = -pow(1 / mid * (x - mid), 2) + 1; // make center bigger
            
            CGFloat y = scaling * maxAmplitude * normedAmplitude * sinf(2 * M_PI *(x / width) * self.frequency + self.phase) + halfHeight;
            
            if (x==0) {
                [wavelinePath moveToPoint:CGPointMake(x, y)];
            }
            else {
                [wavelinePath addLineToPoint:CGPointMake(x, y)];
            }
        }
        
        CAShapeLayer *waveline = [self.waves objectAtIndex:i];
        waveline.path = [wavelinePath CGPath];
        waveline.strokeEnd     = 1.0;
        [waveline setLineWidth:(i==0 ? self.mainWaveWidth : self.decorativeWavesWidth)];
        waveline.strokeColor   = [[UIColor colorWithWhite:1.0 alpha:( 1.0*multiplier )] CGColor];
        UIGraphicsEndImageContext();
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
