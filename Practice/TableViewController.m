//
//  TableViewController.m
//  Practice
//
//  Created by Dikan Chen on 6/9/18.
//  Copyright © 2018 Dikan Chen. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "TableViewCell.h"
#import "Course.h"
#import "images.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Course *> *courses;
@property (strong, nonatomic) NSMutableArray<images *> *pictures;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchJson];
}

- (void)fetchJson
{
    NSString *urlString = [[@"https://www.flickr.com/services/feeds/photos_public.gne?tags=music&format=json&nojsoncallback=1" stringByAppendingString:self.store] stringByAppendingString:@"&format=json&nojsoncallback=1"];
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        NSDictionary *courseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err){
            return;
        }
        NSArray *items = [courseJSON objectForKey:@"items"];
        
        NSMutableArray<Course *> *courses = NSMutableArray.new;
        NSMutableArray<images *> *pictures = NSMutableArray.new;
        for(NSDictionary *courseDict in items){
            NSString *title = courseDict[@"title"];
            NSDictionary *media = courseDict[@"media"];
            NSString *m = [media objectForKey:@"m"];
            Course *course = Course.new;
            images *picture = images.new;
            course.title = title;
            course.imageurl = media;
            picture.m = m;
            [courses addObject:course];
            [pictures addObject:picture];
        }
        self.courses = courses;
        self.pictures = pictures;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }] resume];
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Course *courses = self.courses[indexPath.row];
    images *pictures = self.pictures[indexPath.row];
    cell.flicrimageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pictures.m]]];
    cell.titleLabel.text = courses.title;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

@end
