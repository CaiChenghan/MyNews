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

-(NSArray *)createData{
    NSMutableArray *tpArray = [NSMutableArray array];
    [tpArray addObject:@"习近平同特朗普首次举行会晤"];
    [tpArray addObject:@"中国北方多个城市持续中至重度空气污染"];
    [tpArray addObject:@"加州华裔女子被控谋杀前男友 缴纳数亿保释金后获释"];
    [tpArray addObject:@"新的格局必然带来新的摩擦，因此在一战刚结束没几年，列强就开始了新一轮的海军军备竞赛，这场巨舰大炮竞赛的主角就是英美日法意。【军武次位面】作者：三无青年自新大陆发现以来，随之而来的就是列强们的势力划分和海上争锋，几个世纪的海上厮杀是武器发展最好的催化剂，而战列舰就是这一终极产物。作为次时代海权的象征，..."];
    [tpArray addObject:@"文/小山风最近，沉寂多年的反腐题材又推出重磅大戏《人民的名义》，还是最高检组织创作。再看看卡司：陆毅、张丰毅、吴刚、许亚军、张志坚、柯蓝、胡静……就知道是部巨制。就连头两集的贪官客串都是侯勇，为我们贡献了教科书的演技。所以也不能怪陆毅演技差，只是对手太强，相比之下实在相形见绌，难怪演技会被吐槽。 ..."];
    [tpArray addObject:@"这些天，我们被华为P10以及三星S8的消息炸翻天，很多人表示，国产华为越来越好，虽然被吐槽抄袭苹果没有啥创新，可不论用户体验还是颜值都有巨大提升。同时，三星S8也是惊喜连连，惹得很多手机厂商羡慕嫉妒恨。反观苹果今年发布的iPhone 8，此前小编也写过很多帖子，如果真如爆料信息显示的那样，确实没有什么亮点，眼看..."];
    [tpArray addObject:@"据乌克兰媒体报道，乌克兰美容师弗拉达福缅科哈格蒂近日完成了一例全世界最昂贵的美唇作业。她在客户下唇涂抹带有红色天然色素的魅惑口红，而上唇则由80颗总重量为6.5克拉的钻石点缀，这一特殊美容作业总花费约2.65万美元。这一杰作由这位美容师与另一名珠宝设计师佐伊奇科共同完成，一些媒体称之为“活的美丽创作”..."];
    [tpArray addObject:@"资料图：中国海军核潜艇【环球网军事4月6日报道】美国科技网站Nextbigfuture3日爆料称，中国已经建成建造核潜艇的大规模生产线，能够同时开建多艘核潜艇，将让中国核潜艇数量在近期翻一番。报道称，大多数西方国家的生产线一次只能建造一艘核潜艇，只有美国能够同时开工建造2艘潜艇。中国目前拥有渤海造船厂等三条核潜艇生"];
    [tpArray addObject:@"昨晚，关晓彤与粉丝一同在郊外露营的照片在微博上流传，照片里，关晓彤笑容满面，与粉丝玩的十分开心，甚至系上了围裙，大秀厨艺，引得网友纷纷“嚎叫”——“有事没去成好遗憾，好想吃美彤做的饭”、“晓彤又美啦，还会做饭，内外兼修啊！”。据悉，此次露营实活动为由腾讯娱乐、芒果娱乐、南都娱乐联合制作的星粉互动节"];
    [tpArray addObject:@"近日，据相关数据报告显示，中国服务机器人市场规模在去年(2016年)达到了72.9亿元，同比前年(2015年)增长了44.6%，预计到2019年市场规模保守估计有可能将接近152亿元。作为人工智能领域中重要的一环，中国服务机器人行业在未来五年内可能会将会出现几何式增长。此外，去年光是在智能服务机器人领域出现的融资事件就有70多起..."];
    [tpArray addObject:@"黄易去世：回顾武侠小说在大陆的坎坷往事"];
    [tpArray addObject:@"【观察者网 综合报道】国民党今年5月20日举行党主席新一轮选举，总共有6人领表参选。在任一年多的现任党主席洪秀柱连任之路不被看好，台湾著名学者李敖则认为“谁当选都一样，但吴敦义当选才有重新‘执政’的可能”。国民党主席选举6人领表中国国民党主席选举4月6日迎来最后一天领表，目前已有6人完成领表。这次选举竞争激..."];
    [tpArray addObject:@"楼市闹哄哄的已经有好些日子了，对于普通老百姓而言，一二线城市的房价高得吓人，可望不可即。但梦想还是要有的，万一要在三四线城市买房呢？所以计划买房的技巧还是可以提前学习学习的。多多早前有教大家如何利用Excel做买房计划，今天整理和补充一下，干货不怕多，之前没看过的朋友可以收好哦~还记得多多给大家介绍的XIR..."];
    [tpArray addObject:@"央视网消息：4日，叙利亚伊德利卜省的一座小镇“疑似遭到化学武器袭击”，据称伤亡惨重。而当地时间5日上午，北京时间昨天深夜，联合国安理会召开紧急会议，讨论美国、英国、法国就此事联合提交的一份决议草案。会议上，英国代表还借题发挥，对中国和俄罗斯进行无端的指责和攻击，刘结一则理直气壮地予以了驳斥和警告。"];
    [tpArray addObject:@"四川泸州通报学生死亡事件：排除他杀 没有发现欺凌"];
    
    return tpArray;
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
