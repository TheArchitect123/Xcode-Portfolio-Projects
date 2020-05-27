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
import Toast_Swift;
import SwiftTimer;

//This controller will be used for rendering the Material Cards
internal class DashboardController : BaseViewController {
    //var navigationBar : CustomNavigationBar?;
    var _menuView : NavigationDropdownMenu?;
    var _masterScroll : UIScrollView?
    
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
        
        self.view.makeToast("Welcome to \(AppInformation.ApplicationName). Please select any of the categories to get started with your french studies...", duration: 3.0, position: .bottom)
        
        SetupNavigationBar();
        SetupUIComponents();
        RefreshButton();
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
        _masterScroll = UIScrollView.init(frame: CGRect(x: 0,y: Double(70 + 5.0), width: UIHelper.ScreenWidth, height: calcHeight - 5.0));
        
        _masterScroll!.refreshControl = masterRefreshMngr;
        
        //Categories
        let generalConversationCard = CardCategories.init(category: PhraseCategories.GeneralConversation, frame: CGRect(x: 10,y: 0,width: UIHelper.ScreenWidth - 20.0,height: 350), 63);
        let technologyCard = CardCategories.init(category: PhraseCategories.Technology, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(generalConversationCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 71)
        let gardeningCard = CardCategories.init(category: PhraseCategories.Gardening, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(technologyCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 35)
        let datingCard = CardCategories.init(category: PhraseCategories.Dating, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(gardeningCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 30)
        let emergencyCard = CardCategories.init(category: PhraseCategories.Emergency, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(datingCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 34)
        let familyCard = CardCategories.init(category: PhraseCategories.Family, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(emergencyCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 24)
        let firstTimeCard = CardCategories.init(category: PhraseCategories.FirstTimeMeeting, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(familyCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        let foodCard = CardCategories.init(category: PhraseCategories.Food, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(firstTimeCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        let mathNumbersCard = CardCategories.init(category: PhraseCategories.MathNumbers, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(foodCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        let schoolCard = CardCategories.init(category: PhraseCategories.School, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(mathNumbersCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        let shoppingCard = CardCategories.init(category: PhraseCategories.Shopping, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(schoolCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        let transportCard = CardCategories.init(category: PhraseCategories.Transport, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(shoppingCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        let travelCard = CardCategories.init(category: PhraseCategories.Travel, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(transportCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        let workCard = CardCategories.init(category: PhraseCategories.Work, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(travelCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        
        _masterScroll!.addSubview(generalConversationCard);
        _masterScroll!.addSubview(technologyCard);
        _masterScroll!.addSubview(gardeningCard);
        _masterScroll!.addSubview(datingCard);
        _masterScroll!.addSubview(emergencyCard);
        _masterScroll!.addSubview(familyCard);
//        _masterScroll!.addSubview(firstTimeCard);
//        _masterScroll!.addSubview(foodCard);
//        _masterScroll!.addSubview(mathNumbersCard);
//        _masterScroll!.addSubview(schoolCard);
//        _masterScroll!.addSubview(shoppingCard);
//        _masterScroll!.addSubview(transportCard);
//        _masterScroll!.addSubview(travelCard);
//        _masterScroll!.addSubview(workCard);
        
        #warning ("Calculate the Scroll Size")
        let scrollHeight : Double = Double(generalConversationCard.bounds.height + technologyCard.bounds.height + gardeningCard.bounds.height + datingCard.bounds.height + emergencyCard.bounds.height + familyCard.bounds.height);
        
//        let scrollHeightSecond = Double(mathNumbersCard.bounds.height + schoolCard.bounds.height + shoppingCard.bounds.height + transportCard.bounds.height + travelCard.bounds.height + workCard.bounds.height);
        
        _masterScroll!.contentSize = CGSize.init(width: UIHelper.ScreenWidth, height: (scrollHeight + 100.0));
        
        
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
        
        self.view.addSubview(_masterScroll!);
        self.view.addSubview(floatButton);
    }
    
    @objc private func RefreshButton() {
        self._masterScroll?.refreshControl?.beginRefreshing();
        LoaderHelper.ShowLoaderWithMessage("Refresh all Items");
        
        //Invoke the Rest Api Helper, to consume the backend logic
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            self._masterScroll?.refreshControl?.endRefreshing();
            LoaderHelper.DismissLoaderWithDefault();
        }
        //timer2.fire();
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        _menuView?.hide();
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }
}
