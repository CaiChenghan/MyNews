//
//  MyTabBarController.m
//  MyPlayer
//
//  Created by 蔡成汉 on 2017/4/6.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import "MyTabBarController.h"
#import "HomeViewController.h"
#import "HotViewController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HomeViewController *homeViewController = [[HomeViewController alloc]init];
    MyNavigationController *homeNav = [[MyNavigationController alloc]initWithRootViewController:homeViewController];
    homeNav.title = @"首页";
    
    HotViewController *hotViewController = [[HotViewController alloc]init];
    MyNavigationController *hotNav = [[MyNavigationController alloc]initWithRootViewController:hotViewController];
    hotNav.title = @"热门";
    
    self.viewControllers = @[homeNav,hotNav];
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
