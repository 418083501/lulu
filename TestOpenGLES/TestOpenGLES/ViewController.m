//
//  ViewController.m
//  TestOpenGLES
//
//  Created by lurong on 15/1/29.
//  Copyright (c) 2015年 L. All rights reserved.
//

#import "ViewController.h"
#import "OpenGLView.h"

@interface ViewController ()

@property (nonatomic,strong)UIView *controlView;

@property (nonatomic ,strong)OpenGLView *glView;

@end

@implementation ViewController

-(void)dealloc
{
    [self.glView cleanup];
    self.glView = nil;
    self.controlView = nil;
}


-(UIView *)controlView
{
    
    if (!_controlView) {
        
        CGFloat height = 150;
        
        _controlView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - height, self.view.frame.size.width, height)];
        
        UISlider *sliderX = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        sliderX.tag = 0;
        
        [sliderX addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        sliderX.minimumValue = -3.;
        sliderX.maximumValue = 3.;
        sliderX.value = 0;
        
        [_controlView addSubview:sliderX];
        
        UISlider *sliderRoX = [[UISlider alloc] initWithFrame:CGRectMake(120, 0, 100, 20   )];
        sliderRoX.tag = 1;
        [sliderRoX addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        sliderRoX.minimumValue = -3.;
        sliderRoX.maximumValue = 3.;
        sliderRoX.value = 0;
        
        [_controlView addSubview:sliderRoX];
        
        UISlider *sliderY = [[UISlider alloc] initWithFrame:CGRectMake(0, 50, 100, 20   )];
        sliderY.tag = 2;
        [sliderY addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        sliderY.minimumValue = -3.;
        sliderY.maximumValue = 3.;
        sliderY.value = 0;
        
        [_controlView addSubview:sliderY];
        
        UISlider *sliderScaleZ = [[UISlider alloc] initWithFrame:CGRectMake(120, 50, 100, 20   )];
        sliderScaleZ.tag = 3;
        [sliderScaleZ addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        sliderScaleZ.minimumValue = -3.;
        sliderScaleZ.maximumValue = 3.;
        sliderScaleZ.value = 0;
        
        [_controlView addSubview:sliderScaleZ];
        
        UISlider *sliderZ = [[UISlider alloc] initWithFrame:CGRectMake(0, 100, 100, 20   )];
        sliderZ.tag = 4;
        [sliderZ addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        sliderZ.minimumValue = -3.;
        sliderZ.maximumValue = 3.;
        sliderZ.value = 0;
        
        [_controlView addSubview:sliderZ];
        
    }
    
    return _controlView;
}

-(void)onValueChanged:(UISlider *)slider
{
    
    CGFloat currentValue = slider.value;
    
    NSInteger tag = slider.tag;
    switch (tag) {
        case 0:
        {
            //x
        }
            break;
        case 1:
        {
            //rotX
        }
            break;
        case 2:
        {
            //y
        }
            break;
        case 3:
        {
            //scaleZ
        }
            break;
        case 4:
        {
            //z
        }
            break;
            
        default:
            break;
    }
}



-(void)buildLayout
{
    _glView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_glView];
    [self.view addSubview:self.controlView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayout];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
