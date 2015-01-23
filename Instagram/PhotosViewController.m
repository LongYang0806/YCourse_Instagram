//
//  PhotosViewController.m
//  Instagram
//
//  Created by Long Yang on 1/22/15.
//  Copyright (c) 2015 Grace Wu/Long Yang. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface PhotosViewController () <UITableViewDataSource, UITableViewDelegate>
@property(strong, nonatomic) NSArray *instagrams;
@property (weak, nonatomic) IBOutlet UITableView *instgramTable;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.instgramTable.dataSource = self;
    self.instgramTable.delegate = self;

    UINib *cellNib = [UINib nibWithNibName:@"PhotoCellTableViewCell" bundle:nil];
    [self.instgramTable registerNib:cellNib forCellReuseIdentifier:@"CustomInstagramCell"];
    
    self.instgramTable.rowHeight = 320;
    
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=6f47ba686270482ca9a7baa5bec9d0db"];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData: data options:0 error: nil];
       // NSLog(@"response %@", responseDictionary);
        
        self.instagrams = (NSArray *)[responseDictionary valueForKeyPath:@"data"];
        NSLog(@"%@", self.instagrams);
        
        [self.instgramTable reloadData];

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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.instagrams.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCellTableViewCell *cell = [self.instgramTable dequeueReusableCellWithIdentifier:@"CustomInstagramCell" forIndexPath:indexPath];
    
    NSDictionary *obj = self.instagrams[indexPath.row];
    NSString *urlString = [obj valueForKeyPath:@"images.standard_resolution.url"];
    [cell.instgramImage setImageWithURL:[NSURL URLWithString:urlString]];
    return cell;
}

@end
