//
//  VensionInfoViewController.m
//  SFoofSave
//
//  Created by Lff on 16/8/4.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "VensionInfoViewController.h"

@interface VensionInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *vensionLab;

@end

@implementation VensionInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"版本信息";
    NSString *strVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ;
    _vensionLab.text = [NSString stringWithFormat:@"目前版本:%@",strVersion];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
