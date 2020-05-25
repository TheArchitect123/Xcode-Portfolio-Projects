//
//  DashboardController.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 23/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import CoreGraphics;
import SVProgressHUD;
import Material;
import Motion;
import NavigationDropdownMenu

//This controller will be used for rendering the Material Cards
internal class DashboardController : BaseViewController {
    //var navigationBar : CustomNavigationBar?;
    var _menuView : NavigationDropdownMenu?;
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        //Draw each of the components here.
        //Components:
        /*
         Material based navigation bar
         Card View that will include some details
         Floating button, in order to change some account information
         Navigation Drawer to include customised helpers
         */
        
        SetupNavigationBar();
        SetupUIComponents();
    }
    
    fileprivate func SetupNavigationBar(){
        self.navigationController!.setNavigationBarHidden(true, animated: false);
        
        //        navigationBar = NavigationBarHelper.DrawNavigationWithMenu();
        //        navigationBar!.LeftBarButton.addTarget(self, action: #selector(OpenMenuDrawer), for: UIControl.Event.touchDown);
        
        _menuView = NavigationBarHelper.DrawMenuDropDown();
        _menuView!.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            NavigationHelper.NavigateToCategory(PhraseCategories(rawValue:indexPath) ?? PhraseCategories.GeneralConversation);
        }
        
        self.view.addSubview(_menuView!);
        // self.view!.addSubview(navigationBar!);
    }
    
    @objc fileprivate func OpenMenuDrawer(){
        _menuView?.toggle();
    }
    
    fileprivate func SetupUIComponents(){
        let masterRefreshMngr = UIRefreshControl.init();
        masterRefreshMngr.addTarget(self, action: #selector(RefreshButton), for: UIControl.Event.valueChanged);
        
        let calcHeight = UIHelper.ScreenHeight - Double(70);
        let masterScroll = UIScrollView.init(frame: CGRect(x: 0,y: Double(70 + 5.0), width: UIHelper.ScreenWidth, height: calcHeight - 5.0));
        
        masterScroll.refreshControl = masterRefreshMngr;
        
        //Categories
        let generalConversationCard = CardCategories.init(category: PhraseCategories.GeneralConversation, frame: CGRect(x: 10,y: 0,width: UIHelper.ScreenWidth - 20.0,height: 350));
        let technologyCard = CardCategories.init(category: PhraseCategories.Technology, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(generalConversationCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let gardeningCard = CardCategories.init(category: PhraseCategories.Gardening, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(technologyCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let datingCard = CardCategories.init(category: PhraseCategories.Dating, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(gardeningCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let emergencyCard = CardCategories.init(category: PhraseCategories.Emergency, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(datingCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let familyCard = CardCategories.init(category: PhraseCategories.Family, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(emergencyCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let firstTimeCard = CardCategories.init(category: PhraseCategories.FirstTimeMeeting, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(familyCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let foodCard = CardCategories.init(category: PhraseCategories.Food, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(firstTimeCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let mathNumbersCard = CardCategories.init(category: PhraseCategories.MathNumbers, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(foodCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let schoolCard = CardCategories.init(category: PhraseCategories.School, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(mathNumbersCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let shoppingCard = CardCategories.init(category: PhraseCategories.Shopping, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(schoolCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let transportCard = CardCategories.init(category: PhraseCategories.Transport, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(shoppingCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let travelCard = CardCategories.init(category: PhraseCategories.Travel, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(transportCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        let workCard = CardCategories.init(category: PhraseCategories.Work, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(travelCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350))
        
        masterScroll.addSubview(generalConversationCard);
        masterScroll.addSubview(technologyCard);
        masterScroll.addSubview(gardeningCard);
        masterScroll.addSubview(datingCard);
        masterScroll.addSubview(emergencyCard);
        masterScroll.addSubview(familyCard);
        masterScroll.addSubview(firstTimeCard);
        masterScroll.addSubview(foodCard);
        masterScroll.addSubview(mathNumbersCard);
        masterScroll.addSubview(schoolCard);
        masterScroll.addSubview(shoppingCard);
        masterScroll.addSubview(transportCard);
        masterScroll.addSubview(travelCard);
        masterScroll.addSubview(workCard);
        
        #warning ("Calculate the Scroll Size")
        let scrollHeight : Double = Double(generalConversationCard.bounds.height + technologyCard.bounds.height + gardeningCard.bounds.height + datingCard.bounds.height + emergencyCard.bounds.height + familyCard.bounds.height + firstTimeCard.bounds.height + foodCard.bounds.height);
        
        let scrollHeightSecond = Double(mathNumbersCard.bounds.height + schoolCard.bounds.height + shoppingCard.bounds.height + transportCard.bounds.height + travelCard.bounds.height + workCard.bounds.height);
        
        masterScroll.contentSize = CGSize.init(width: UIHelper.ScreenWidth, height: (scrollHeight + scrollHeightSecond + 150.0));
        
        
        //Floating Button
        let floatButton : Button = Button.init(frame: CGRect(x: UIHelper.ScreenWidth - 90.0, y: UIHelper.ScreenHeight - 90.0, width: 70, height: 70));
        floatButton.backgroundColor = ColorHelper.LightOrange();
        floatButton.layer.cornerRadius = 35.0;
        floatButton.setImage(UIImage.init(named: ImageConstants._refreshIcon), for: UIControl.State.normal);
        floatButton.setImage(UIImage.init(named: ImageConstants._refreshIcon), for: UIControl.State.highlighted);
        floatButton.setImage(UIImage.init(named: ImageConstants._refreshIcon), for: UIControl.State.selected);
        floatButton.addTarget(self, action: #selector(RefreshButton), for: UIControl.Event.touchDown);
        
        //        floatButton.setImage(UIImage.init(named: Icon.check), for: UIControl.State.normal);
        //        floatButton.setImage(UIImage.init(named: Icon.check), for: UIControl.State.normal);
        //        floatButton.setImage(UIImage.init(named: Icon.check), for: UIControl.State.normal);
        
        self.view.addSubview(masterScroll);
        self.view.addSubview(floatButton);
    }
    
    @objc private func RefreshButton() {
        
        SVProgressHUD.show(withStatus: "Refresh all Items");
    }
    
    private func ConfigureNavigationDrawer(){
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        _menuView?.hide();
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }
}
