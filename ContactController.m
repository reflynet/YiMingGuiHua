//
//  ContactController.m
//  yiming
//
//  Created by weiwei wei on 15/8/10.
//  Copyright (c) 2015年 reflynet. All rights reserved.
//

#import "ContactController.h"
#import "YMCommon.h"
@implementation ContactController
@synthesize _contactController;
@synthesize _linkManContrller;
@synthesize _city;
@synthesize Title;
-(void)viewDidLoad
{
    
     self.navigationController.title = Title;
   
 
   [self.view setBounds:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y-self.navigationController.navigationBar.frame.size.height-12,
                                   self.view.bounds.size.width,self.view.bounds.size.height)];
    
  //  [self.view setFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y-50,
        //                            self.view.bounds.size.width,self.view.bounds.size.height)];
    
    NSArray *array = [NSArray arrayWithObjects:@"通讯录",@"记录", nil];
    UISegmentedControl *segmentedController = [[UISegmentedControl alloc] initWithItems:array];
    segmentedController.segmentedControlStyle = UISegmentedControlSegmentCenter;
    
   /* NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil,UITextAttributeFont ,[UIColor whiteColor],UITextAttributeTextShadowColor ,nil];
    
   
    [segmentedController setTitleTextAttributes:dic forState:UIControlStateSelected];

    */
   // segmentedController.tintColor=[YMCommon hexStringToColor:@"fff"];
    
    [segmentedController setTitleTextAttributes:@{NSForegroundColorAttributeName:[YMCommon hexStringToColor:@"cf0001"]} forState:UIControlStateSelected];
    
    [segmentedController addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedController.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segmentedController;
    self._contactController =    [self.storyboard instantiateViewControllerWithIdentifier:@"contactcategory"];
      self._linkManContrller =    [self.storyboard instantiateViewControllerWithIdentifier:@"linkman"];
    
    [self.view addSubview:_contactController.view];
    [self.view addSubview:_linkManContrller.view];
    self._linkManContrller.currentNav = self.navigationController;
    self._contactController.currentNav = self.navigationController;
    self._linkManContrller.currentNavItem = self.navigationItem;
    self._contactController.currentNavItem = self.navigationItem;

    [super viewDidLoad];
 

}

-(void)segmentAction:(UISegmentedControl *)Seg
{
     NSInteger Index = Seg.selectedSegmentIndex;
    
    if(Index==0)
    {
        [self.view bringSubviewToFront:_linkManContrller.view];
        
    /*    if(self._linkManContrller == nil)
        {
         self._linkManContrller =    [self.storyboard instantiateViewControllerWithIdentifier:@"linkman"];
        }
            [self.view insertSubview:self._linkManContrller.view atIndex:1];
        
        if(self._contactController != nil)
        {
        [self._contactController.view removeFromSuperview];
        }
     */

        
    }
    else{
        [self.view bringSubviewToFront:_contactController.view];
     /*   if(self._contactController == nil)
        {
            self._contactController =    [self.storyboard instantiateViewControllerWithIdentifier:@"contactcategory"];
        }
            [self.view insertSubview:self._contactController.view atIndex:1];
        
        if(self._linkManContrller != nil)
        {
          [self._linkManContrller.view removeFromSuperview];
        }
*/
        
    }
}


@end
