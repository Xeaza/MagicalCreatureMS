//
//  ViewController.m
//  MCMS
//
//  Created by Taylor Wright-Sanson on 10/7/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "ViewController.h"
#import "MagicalCreature.h"
#import "CreatureViewController.h"
#import "AttackViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIBarButtonItem *leftBarButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    MagicalCreature *norwegianRidgeback = [[MagicalCreature alloc] initWithName:@"Norwegian Ridgeback"];
    norwegianRidgeback.weaponOfChoice = @"Mouth Flame Thrower";
    norwegianRidgeback.image = [UIImage imageNamed:@"dragon.jpg"];
    norwegianRidgeback.accessories = [NSMutableArray arrayWithObjects:@"Nail Clippers", @"Scale Grout", @"Camping Stove", @"Tide to Go", nil];

    MagicalCreature *flobberWorm = [[MagicalCreature alloc] initWithName:@"Flobberworm"];
    flobberWorm.weaponOfChoice = @"Lettuce";
    flobberWorm.image = [UIImage imageNamed:@"worm.jpg"];;
    flobberWorm.accessories = [NSMutableArray arrayWithObjects:@"Grass Stains", @"Tummy Lube", @"Apple Sauce",@"Second Heart AED", nil];

    MagicalCreature *mountainTroll = [[MagicalCreature alloc] initWithName:@"Mountain Troll"];
    mountainTroll.weaponOfChoice = @"Club";
    mountainTroll.image = [UIImage imageNamed:@"troll.jpg"];
    mountainTroll.accessories = [NSMutableArray arrayWithObjects:@"Club Oil", @"Hand Wipes", @"Nose Glue", @"Leather Gloves", nil];

    MagicalCreature *blibberingHumdinger = [[MagicalCreature alloc] initWithName:@"Blibbering Humdinger"];
    blibberingHumdinger.weaponOfChoice = @"Ask Luna";
    blibberingHumdinger.image = [UIImage imageNamed:@"calvin.png"];
    blibberingHumdinger.accessories = [NSMutableArray arrayWithObjects:@"?????", @"??????", @"?????", @"??????", nil];

    MagicalCreature *nargle = [[MagicalCreature alloc] initWithName:@"Nargle"];
    nargle.weaponOfChoice = @"Slight of hand";
    nargle.image = [UIImage imageNamed:@"nargal.jpg"];
    nargle.accessories = [NSMutableArray arrayWithObjects:@"Ear Phones", @"Wing Pit Powder", @"Gilly Weed", @"Mistletoe", nil];

    self.creatures = [NSMutableArray arrayWithObjects:norwegianRidgeback, flobberWorm, mountainTroll, blibberingHumdinger, nargle, nil];

    /*self.leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"ATTACK!"
                                                           style:UIBarButtonItemStyleDone
                                                          target:self action:@selector(onAttackButtonPressed:)];
    self.navigationItem.leftBarButtonItem = self.leftBarButton; */

}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = nil;
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellID" forIndexPath:indexPath];

    MagicalCreature *creature = [self.creatures objectAtIndex:indexPath.row];
    cell.textLabel.text = creature.name;
    cell.detailTextLabel.text = creature.weaponOfChoice;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.creatures.count;
}

- (IBAction)onAddButtonPressed:(id)sender
{
    MagicalCreature *creature = [[MagicalCreature alloc] initWithName:self.textField.text];
    creature.weaponOfChoice = @"Nothing, you got here late...";
    // Don't forget to add the object to the beginning of the creatures array
    [self.creatures insertObject:creature atIndex:0];

    // Insert the row at the beginning of the tableview
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];

    self.textField.text = @"";
    [self.textField resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //CreatureViewController *creatureViewController = segue.destinationViewController;
    //[self performSegueWithIdentifier:@"showCreatureSegue" sender:self];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

    if ([segue.identifier isEqualToString:@"showCreatureSegue"])
    {
        CreatureViewController *creatureViewController = segue.destinationViewController;
        creatureViewController.creature = [self.creatures objectAtIndex:indexPath.row];
    }

    else if ([segue.identifier isEqualToString:@"attackSegue"])
    {
        AttackViewController *attackViewController = segue.destinationViewController;
        attackViewController.attackLineup = self.attackLineup;
        [self.tableView setEditing:NO animated:YES];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEditing])
    {
        if (self.attackLineup.count < 2)
        {
            [self.attackLineup addObject:[self.creatures objectAtIndex:indexPath.row]];
        }
        if (self.attackLineup.count == 2)
        {
            [self performSegueWithIdentifier:@"attackSegue" sender:self];
        }
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"showCreatureSegue"] && [self.tableView isEditing])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (IBAction)onAttackButtonPressed:(UIBarButtonItem *)rightBarButton
{
    self.attackLineup = [[NSMutableArray alloc] init];

    self.navigationItem.title = @"Choose Your Opponents";
    [self.tableView setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
