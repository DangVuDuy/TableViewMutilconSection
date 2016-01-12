//
//  TableViewMultiSection.m
//  TableViewMultiSection
//
//  Created by Dang Vu Duy on 1/9/16.
//  Copyright © 2016 Dang Vu Duy. All rights reserved.
//

#import "TableViewMultiSection.h"
#import "Person.h"
@interface TableViewMultiSection ()

@end

@implementation TableViewMultiSection {
    
    NSMutableArray *arrayData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayData = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 0; i < 5; i++) {
        Person *personData = [[Person alloc] init];
        [arrayData addObject:personData];
    }
    //Chọn nhiều row 1 lúc
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(OnAdd)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(OnEdit)];
    
    
    
}
// Thêm row
-(void) OnAdd {
    
    Person *personData = [[Person alloc] init];
    [arrayData addObject:personData];
    [self.tableView reloadData];
    
//    if([arrayData count] > 0){
//        if (self.tableView.editing) {
//            [self.tableView setEditing:true animated:YES];
    
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                                     style:UIBarButtonItemStylePlain
                                                                                    target:self action:@selector(OnEdit)];
//        }
//    }

}

-(void) OnEdit {
    if (self.tableView.editing) {
        
        [self.tableView setEditing:false animated:YES];
        //Set button Delete ==> Add
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                               target:self
                                                                                               action:@selector(OnAdd)];
        //Set button Done ==> Button Edit
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self action:@selector(OnEdit)];
        
    }else{
        [self.tableView setEditing:true animated:YES];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(OnDelete)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(OnEdit)];
    }
    
    
}
// Xoá nhiều Row
-(void) OnDelete {
    
    NSArray *selectedRow;
    selectedRow = self.tableView.indexPathsForSelectedRows;
    if (selectedRow.count > 0) {
        NSMutableIndexSet *indicesofItemToDelete = [[NSMutableIndexSet alloc] init];
        for (NSIndexPath *selectedIndex in selectedRow) {
            
            [indicesofItemToDelete addIndex:selectedIndex.row];
        }
        [arrayData removeObjectsAtIndexes:indicesofItemToDelete];
        [self.tableView deleteRowsAtIndexPaths:selectedRow withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    if ([arrayData count] == 0) {
        if (self.tableView.editing) {
            [self.tableView setEditing:false animated:YES];
            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                                   target:self
                                                                                                   action:@selector(OnAdd)];
            
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]init];
        }
    }
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayData.count;
}
// Đổ dữ liệu lên cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Person *personData = [[Person alloc] init];
    personData = arrayData[indexPath.row];
    cell.textLabel.text = personData.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", personData.age];
    
    return cell;
}
// Xoá 1 row băng việc trượt cell sang trái
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrayData removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}
//Thay đổi vị trí của Row
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    Person *person = [[Person alloc] init];
    person = arrayData[sourceIndexPath.row];
    [arrayData removeObjectAtIndex:sourceIndexPath.row];
    [arrayData insertObject:person atIndex:destinationIndexPath.row];
    
}
@end
