//
//  HomeViewController.m
//  DemoOfLayoutCell
//
//  Created by 蔡成汉 on 2017/4/7.
//  Copyright © 2017年 上海泰侠网络科技有限公司. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsCell.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITableView *myTableView;
@property (nonatomic , strong) NSMutableArray *dataArray;

@end

@implementation HomeViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"新闻";
    
    _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.separatorInset = UIEdgeInsetsZero;
    _myTableView.layoutMargins = UIEdgeInsetsZero;
    _myTableView.tableFooterView = [UIView new];
    [self.view addSubview:_myTableView];
    
    [_myTableView registerClass:[NewsCell class] forCellReuseIdentifier:@"NewsCell"];
    
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_myTableView.mj_header beginRefreshing];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideTop);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myNews = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = (NewsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell getLayoutCellHeightWithFlex:8];
}


#pragma mark - NetWork

-(void)refreshData{
    [self loadDataFromServer:YES];
}

-(void)loadMoreData{
    [self loadDataFromServer:NO];
}

-(void)loadDataFromServer:(BOOL)refresh{
    MJWeakSelf;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"1114283782" forKey:@"clientid"];
    [param setValue:@"1.1" forKey:@"v"];
    [param setValue:@"toutiao" forKey:@"type"];
    [param setValue:@"3001_9223370545054981573_48bc0275b9d2062b" forKey:@"startkey"];
    [param setValue:@"" forKey:@"newkey"];
    [param setValue:@"00000000-0000-0000-0000-000000000000" forKey:@"ime"];
    [param setValue:@"ZJZYIOS1114283782" forKey:@"apptypeid"];
    [param setValue:@"1" forKey:@"rn"];
    [param setValue:@"20" forKey:@"size"];
    
    NSInteger index = 1;
    if (refresh != YES) {
        //加载更多
    }
    [param setValue:[NSNumber numberWithInteger:index] forKey:@"index"];
    
    [[ConnectManager shareManager]getWithURLString:klURLForNews param:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if (refresh == YES) {
            //下拉刷新
            [weakSelf.dataArray removeAllObjects];
        }
        if (responseObject) {
            NSArray *tpArray = [responseObject getArrayValueForKey:@"NewsList"];
            if (tpArray) {
                for (int i=0; i<tpArray.count; i++) {
                    MyNews *tpNews = [[MyNews alloc]initWithDic:[tpArray objectAtIndex:i]];
                    [weakSelf.dataArray addObject:tpNews];
                }
            }
        }
        [weakSelf.myTableView reloadData];
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.domain);
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView.mj_footer endRefreshing];
    }];
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
