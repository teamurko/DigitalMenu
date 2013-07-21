//
//  OrderViewController.h
//  DigitalMenu
//
//  Created by Stanislav Pak on 21.07.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UILabel *totalPrice_;
    UITableView *dishesTable_;
}
@end
