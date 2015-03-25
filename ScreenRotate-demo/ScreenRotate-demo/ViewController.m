//
//  ViewController.m
//  ScreenRotate-demo
//
//  Created by apple on 15/3/25.
//  Copyright (c) 2015年 thinker. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UIImageView * glView;
    UIDeviceOrientation orientation;
    CGFloat screenWidth;
    CGFloat screenHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIApplicationDidChangeStatusBarOrientationNotification  object:nil];
    orientation = (UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation;    //This is more reliable than (self.interfaceOrientation) and [[UIDevice currentDevice] orientation] (which may give a faceup type value)
    if (orientation == UIDeviceOrientationUnknown || orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown)
    {
        orientation = UIDeviceOrientationPortrait;
    }
    
    glView = [[UIImageView alloc]init];
    glView.backgroundColor = [UIColor redColor];
    [self initWindowViews];
    [self.view addSubview:glView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRotate:(NSNotification *)notification{
    
    UIDeviceOrientation newOrientation = [[UIDevice currentDevice] orientation];
    if (newOrientation != UIDeviceOrientationPortraitUpsideDown && newOrientation != UIDeviceOrientationUnknown && newOrientation != UIDeviceOrientationFaceUp && newOrientation != UIDeviceOrientationFaceDown && newOrientation != orientation){
        orientation =   newOrientation;
        [self initWindowViews];
    }
}

-(void)initWindowViews{
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
        [self setToLandscape];
    }else{
        [self setToPortrait];
    }
}

-(void)setToLandscape{
    [self.navigationController setNavigationBarHidden:YES];
    CGFloat width = screenWidth/0.75;
    [glView setFrame:CGRectMake((screenHeight-width)/2, 0, width, screenWidth)];
    NSLog(@"didRotate landscape  : CGFloat x=%f, CGFloat y=%f, CGFloat width=%f, CGFloat height=%f ",(screenHeight-width)/2,0.0,width,screenWidth);
}

-(void)setToPortrait{
    [self.navigationController setNavigationBarHidden:NO];
    CGFloat height = screenWidth * 0.75;
    [glView setFrame:CGRectMake(0, (screenHeight-height)/2, screenWidth, height)];
    NSLog(@"didRotate portrait  : CGFloat x=%f, CGFloat y=%f, CGFloat width=%f, CGFloat height=%f ",0.0,(screenWidth-height)/2,screenWidth,height);
}

//// iOS5.0
//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
//    return UIInterfaceOrientationMaskAllButUpsideDown;  // 可以修改为任何方向
//}
//
//-(NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskAllButUpsideDown;  // 可以修改为任何方向
//}
//
//-(BOOL)shouldAutorotate{
//    return YES;
//}


@end
