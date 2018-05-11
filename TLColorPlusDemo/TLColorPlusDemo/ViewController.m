//
//  ViewController.m
//  TLColorPlusDemo
//
//  Created by tonyli on 5/11/18.
//  Copyright © 2018 tonyli. All rights reserved.
//

#import "ViewController.h"
#import <TLColorPlus/TLColorPlus.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *cube;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    
    NSMutableArray<UIColor*> *cgColors = [[NSMutableArray<UIColor*> alloc] init];
    [cgColors addObject:[UIColor colorWithHexString:@"#F58A1E"]];
    [cgColors addObject:[UIColor colorWithHexString:@"#F24540"]];
    
     _cube.backgroundColor = [UIColor
                              colorWithGradientColor: cgColors
                              withPositions:@[@0.05,@1]
                              withAngle: 123
                              withFrame: _cube.frame];
}

@end
