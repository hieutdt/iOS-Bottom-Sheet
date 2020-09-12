//
//  ViewController.m
//  MI Component
//
//  Created by HieuTDT on 9/6/20.
//  Copyright © 2020 HieuTDT. All rights reserved.
//

#import "ViewController.h"

#import "BottomSheetManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBlueColor;
}

- (IBAction)showBottomSheet:(id)sender {
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor redColor];
    
    [[BottomSheetManager instance] showBottomSheetWithContent:contentView
                                                       height:300
                                                  canExpanded:YES];
}


@end
