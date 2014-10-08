//
//  CreatureViewController.m
//  MCMS
//
//  Created by Taylor Wright-Sanson on 10/7/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "CreatureViewController.h"

@interface CreatureViewController () <UITextFieldDelegate, UITableViewDataSource, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weaponLabel;

@property (strong, nonatomic) UIBarButtonItem *rightBarButton;
@end

@implementation CreatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.navigationItem.title = self.creature.name;
    self.textField.text = self.creature.name;
    self.textField.hidden = YES;
    self.nameLabel.text = self.creature.name;
    self.weaponLabel.text = self.creature.weaponOfChoice;
    self.imageView.image = self.creature.image;

    self.rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                           style:UIBarButtonItemStyleDone
                                                          target:self action:@selector(onEditButtonPressed:)];
    self.navigationItem.rightBarButtonItem = self.rightBarButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)rightBarButton
{
    if ([rightBarButton.title isEqualToString:@"Edit"])
    {
        [self.textField becomeFirstResponder];
        self.navigationItem.rightBarButtonItem.title = @"Done";
        self.textField.hidden = NO;
        self.nameLabel.hidden = YES;
    }
    else
    {
        rightBarButton.title = @"Edit";
        self.creature.name = self.textField.text;
        self.nameLabel.text = self.creature.name;
        self.navigationItem.title = self.textField.text;
        self.textField.hidden = YES;
        self.nameLabel.hidden = NO;
        [self.textField resignFirstResponder];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // Tell the keyboard where to go on next / go button.
    if(textField == self.textField)
    {
        self.navigationItem.rightBarButtonItem.title = @"Edit";
        self.creature.name = self.textField.text;
        self.navigationItem.title = self.textField.text;
        self.nameLabel.text = self.creature.name;
        self.textField.hidden = YES;
        self.nameLabel.hidden = NO;
        [self.textField resignFirstResponder];
    }

    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.creature.accessories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccessoryCellID" forIndexPath:indexPath];
    cell.textLabel.text = [self.creature.accessories objectAtIndex:indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // Custom Label for section header - Did it so I could center the label - default is left aligned
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont systemFontOfSize:14];
    headerLabel.text = @"EQUIPED ACCESSORIES";


    return headerLabel;
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
