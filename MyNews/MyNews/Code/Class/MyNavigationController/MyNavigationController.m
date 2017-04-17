//
//  MyNavigationController.m
//  MyPlayer
//
//  Created by 蔡成汉 on 2017/4/6.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import "MyNavigationController.h"

@interface MyNavigationController ()

@end

@implementation MyNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self initialMyNavigationController];
        self.viewControllers = @[rootViewController];
    }
    return self;
}

-(void)initialMyNavigationController{
    //设置tabbar按钮未选中状态文字大小、颜色
    UIFont *unSelectFont = [UIFont boldSystemFontOfSize:12];
    UIColor *unSelectColor = [UIColor grayColor];
    NSMutableDictionary *attributDicNor = [NSMutableDictionary dictionary];
    [attributDicNor setValue:unSelectFont forKey:NSFontAttributeName];
    [attributDicNor setValue:unSelectColor forKey:NSForegroundColorAttributeName];
    
    //设置tabbar按钮选中状态文字大小、颜色
    UIFont *selectFont = [UIFont boldSystemFontOfSize:12];
    UIColor *selectColor = [UIColor blackColor];
    NSMutableDictionary *attributDicSelect = [NSMutableDictionary dictionary];
    [attributDicSelect setValue:selectFont forKey:NSFontAttributeName];
    [attributDicSelect setValue:selectColor forKey:NSForegroundColorAttributeName];
    
    //设置导航标题文字大小、颜色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    [attributes setValue:[UIFont boldSystemFontOfSize:17] forKey:NSFontAttributeName];
    
    [self.tabBarItem setTitleTextAttributes:attributDicNor forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:attributDicSelect forState:UIControlStateSelected];
    //导航标题
    self.navigationBar.titleTextAttributes = attributes;
    //导航返回按钮颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    //导航颜色
    self.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    viewController.hidesBottomBarWhenPushed = YES;
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
