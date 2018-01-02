/********* ymyImprove.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "MainViewController.h"

@interface ymyImprove : CDVPlugin <UIGestureRecognizerDelegate> {
  // Member variables go here.
}

- (void)pluginInitialize;
@end

@implementation ymyImprove

- (void)pluginInitialize
{
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(initImprove) userInfo:nil repeats:NO];
    
}

- (void)initImprove{
    MainViewController *vc = [self getCurrentMainViewController];
    vc.webView.scrollView.bounces = NO;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:nil];
    longPress.delegate = self;
    longPress.minimumPressDuration = 0.4;
    [vc.webView addGestureRecognizer:longPress];
}

- (MainViewController *)getCurrentMainViewController
{
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tempWin in windows)
        {
            if(tempWin.windowLevel == UIWindowLevelNormal)
            {
                window = tempWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    //当前的响应者是否属于UIViewController类
    if([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return (MainViewController*)result;
}
@end
