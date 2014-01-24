//
//  NewYorkCityViewController.m
//  I'mInNewYorkCity
//
//  Created by Yukui ye on 1/24/14.
//  Copyright (c) 2014 Yukui Ye. All rights reserved.
//

#import "NewYorkCityViewController.h"


@interface NewYorkCityViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;

@end

@implementation NewYorkCityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    UIFont *font1 = [UIFont fontWithName:@"Zapfino" size:10.0f];
    UIFont *font2 = [UIFont fontWithName:@"HelveticaNeue-Medium"  size:15.0f];
    
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                            NSFontAttributeName:font1};
    NSDictionary *dict2 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font2};
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Cannot Miss\n"    attributes:dict1]];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Place"      attributes:dict2]];
    
    
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, attString.length)];
    
    
    self.btn2.titleLabel.shadowOffset = CGSizeMake(2.0, 0);
    self.btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btn2 setAttributedTitle:attString forState:UIControlStateNormal];
    self.btn2.titleLabel.numberOfLines = 0;
    self.btn2.titleLabel.lineBreakMode =NSLineBreakByWordWrapping;
    
    self.btn2.backgroundColor = [UIColor colorWithRed:255/255. green:182/255. blue:193/255. alpha:0.3];
    self.btn2.clipsToBounds = YES;
    self.btn2.layer.cornerRadius = self.btn2.frame.size.width/2;
    self.btn2.opaque = YES;

}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self startMyMotionDetect];
    CGAffineTransform transform2 = self.btn2.transform;
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.btn2.transform = CGAffineTransformRotate(CGAffineTransformScale(transform2, 1, 1), M_PI/2);
                     }completion:^(BOOL finished){
                         if (finished) {
                             [UIView animateWithDuration:1
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.btn2.transform = CGAffineTransformRotate(CGAffineTransformScale(transform2, 0.7, 0.7), -M_PI/2);
                                              }completion:^(BOOL finished){
                                                  if (finished) {
                                                      [UIView animateWithDuration:1
                                                                            delay:0
                                                                          options:UIViewAnimationOptionCurveLinear
                                                                       animations:^{
                                                                           self.btn2.transform = CGAffineTransformRotate(CGAffineTransformScale(transform2, 1, 1), M_PI/2);
                                                                       }completion:^(BOOL finished){
                                                                           if (finished) {
                                                                               [UIView animateWithDuration:1
                                                                                                     delay:0
                                                                                                   options:UIViewAnimationOptionCurveLinear
                                                                                                animations:^{
                                                                                                    self.btn2.transform = CGAffineTransformRotate(CGAffineTransformScale(transform2, 0.7, 0.7), -M_PI/2);
                                                                                                }completion:^(BOOL finished){
                                                                                                    self.btn2.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                                                                                                }];
                                                                           }
                                                                       }];
                                                      
                                                  }
                                              }];
                         }
                         
                     }];
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [self.motionManager stopAccelerometerUpdates];
    
}


- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}


- (void)startMyMotionDetect
{
    
    __block float stepMoveFactor = 15;
    
    [self.motionManager
     startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
     withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            
                            CGRect rect = self.btn1.frame;
                            
                            float movetoX = rect.origin.x + (data.acceleration.x * stepMoveFactor);
                            float maxX = self.view.frame.size.width - rect.size.width;
                            
                            float movetoY = (rect.origin.y + rect.size.height)
                            - (data.acceleration.y * stepMoveFactor);
                            
                            float maxY = self.view.frame.size.height;
                            
                            if ( movetoX > 0 && movetoX < maxX ) {
                                rect.origin.x += (data.acceleration.x * stepMoveFactor);
                            }; 
                            
                            if ( movetoY > 0 && movetoY < maxY ) {
                                rect.origin.y -= (data.acceleration.y * stepMoveFactor);
                            };
                            
                            [UIView animateWithDuration:0 delay:0
                                                 options:UIViewAnimationCurveEaseInOut
                                             animations:
                             ^{
                                 self.btn1.frame = rect;
                             }
                                             completion:nil
                             ];
                            
                        }
                        );
     }
     ];
    
}


@end
