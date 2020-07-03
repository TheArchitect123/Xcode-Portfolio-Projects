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
    var _floatBtn : Button?;
    
    let initMacWindowSize : CGSize = CGSize.init(width: 768, height: 1024);
    
    //Categories
    var GeneralConversationCard : CardCategories?;
    var TechnologyCard : CardCategories?;
    var GardeningCard : CardCategories?;
    var DatingCard : CardCategories?;
    var EmergencyCard : CardCategories?;
    var FamilyCard : CardCategories?;
    
    fileprivate var isInitialized : Bool = false;
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
        
        //#if TARGET_OS_MACCATALYST
       // self.setupMacCatalyst(application : UIApplication.shared);
        self.resizeMacElements(initMacWindowSize);
        //#endif
    }
    
//    func setupMacCatalyst(application : UIApplication)
//    {
//        for scene : UIScene in application.connectedScenes {
//
//            if (scene.isKind(of: UIWindowScene.self)) {
//               // let windowScene : UIWindowScene = scene as! UIWindowScene;
//               // windowScene.sizeRestrictions!.maximumSize = initMacWindowSize;
//                //windowScene.sizeRestrictions.minimumSize = initMacWindowSize;
//            }
//        }
//    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        //Reshape the Cards along with the parent scroll
        resizeMacElements(size);
    }
    
    fileprivate func resizeMacElements(_ size: CGSize){
        if(self.isInitialized){
            self._menuView!.frame = CGRect.init(x: 0, y: 0, width: size.width, height: 70);
            self.GeneralConversationCard?.frame = CGRect(x: 10,y: 0, width: size.width - 20.0, height: 350);
            self.TechnologyCard?.frame =  CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(self.GeneralConversationCard!) + 10.0, width: Double(size.width) - 20.0,height: 350);
            self.GardeningCard!.frame = CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(self.TechnologyCard!) + 10.0, width: Double(size.width) - 20.0,height: 350);
            self.DatingCard!.frame = CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(self.GardeningCard!) + 10.0, width: Double(size.width) - 20.0,height: 350);
            self.EmergencyCard!.frame =  CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(self.DatingCard!) + 10.0, width: Double(size.width) - 20.0,height: 350);
            self.FamilyCard!.frame = CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(self.EmergencyCard!) + 10.0, width: Double(size.width) - 20.0,height: 350);
            
            
            //Reset the Content Size on Window Size Adjustment
            let calcHeight = Double(size.height) - Double(70);
            self._masterScroll!.frame = CGRect(x: 0,y: Double(70 + 5.0), width: Double(size.width), height: calcHeight - 5.0);
            
            let scrollHeight : Double = Double(self.GeneralConversationCard!.bounds.height + self.TechnologyCard!.bounds.height + self.GardeningCard!.bounds.height + self.DatingCard!.bounds.height + self.EmergencyCard!.bounds.height + self.FamilyCard!.bounds.height);
            
            self._masterScroll!.contentSize = CGSize.init(width: Double(size.width), height: (scrollHeight + 100.0));
            _masterScroll!.contentSize = CGSize.init(width: Double(size.width), height: (scrollHeight + 100.0));
            
            //Adjust frame of float
            self._floatBtn!.frame = CGRect(x: size.width - 90.0, y: size.height - 90.0, width: 70, height: 70);
        }
    }
    
    fileprivate func SetupNavigationBar(){
        self.navigationController!.setNavigationBarHidden(true, animated: false);
        
        //        navigationBar = NavigationBarHelper.DrawNavigationWithMenu();
        //        navigationBar!.LeftBarButton.addTarget(self, action: #selector(OpenMenuDrawer), for: UIControl.Event.touchDown);
        
        self._menuView = NavigationBarHelper.DrawMenuDropDown();
        self._menuView!.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            NavigationHelper.NavigateToCategory(PhraseCategories(rawValue:indexPath) ?? PhraseCategories.GeneralConversation);
        };
        
        self._menuView!.frame = CGRect.init(x: 0, y: 0, width: self.navigationController!.navigationBar.bounds.width, height: 70);
        
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
        self.GeneralConversationCard = CardCategories.init(category: PhraseCategories.GeneralConversation, frame: CGRect(x: 10,y: 0,width: UIHelper.ScreenWidth - 20.0,height: 350), 63);
        self.TechnologyCard = CardCategories.init(category: PhraseCategories.Technology, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(self.GeneralConversationCard!) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 71)
        self.GardeningCard = CardCategories.init(category: PhraseCategories.Gardening, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(self.TechnologyCard!) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 35)
        self.DatingCard = CardCategories.init(category: PhraseCategories.Dating, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(self.GardeningCard!) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 30)
        self.EmergencyCard = CardCategories.init(category: PhraseCategories.Emergency, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(self.DatingCard!) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 34)
        self.FamilyCard = CardCategories.init(category: PhraseCategories.Family, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(self.EmergencyCard!) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 24);
        
        //        let firstTimeCard = CardCategories.init(category: PhraseCategories.FirstTimeMeeting, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(familyCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        //        let foodCard = CardCategories.init(category: PhraseCategories.Food, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(firstTimeCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        //        let mathNumbersCard = CardCategories.init(category: PhraseCategories.MathNumbers, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(foodCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        //        let schoolCard = CardCategories.init(category: PhraseCategories.School, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(mathNumbersCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        //        let shoppingCard = CardCategories.init(category: PhraseCategories.Shopping, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(schoolCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        //        let transportCard = CardCategories.init(category: PhraseCategories.Transport, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(shoppingCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        //        let travelCard = CardCategories.init(category: PhraseCategories.Travel, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(transportCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        //        let workCard = CardCategories.init(category: PhraseCategories.Work, frame: CGRect(x: 10,y:UIHelper.GetMaxYCoordinate(travelCard) + 10.0, width: UIHelper.ScreenWidth - 20.0,height: 350), 0)
        //
        _masterScroll!.addSubview(self.GeneralConversationCard!);
        _masterScroll!.addSubview(self.TechnologyCard!);
        _masterScroll!.addSubview(self.GardeningCard!);
        _masterScroll!.addSubview(self.DatingCard!);
        _masterScroll!.addSubview(self.EmergencyCard!);
        _masterScroll!.addSubview(self.FamilyCard!);
        //        _masterScroll!.addSubview(firstTimeCard);
        //        _masterScroll!.addSubview(foodCard);
        //        _masterScroll!.addSubview(mathNumbersCard);
        //        _masterScroll!.addSubview(schoolCard);
        //        _masterScroll!.addSubview(shoppingCard);
        //        _masterScroll!.addSubview(transportCard);
        //        _masterScroll!.addSubview(travelCard);
        //        _masterScroll!.addSubview(workCard);
        
        #warning ("Calculate the Scroll Size")
        let scrollHeight : Double = Double(self.GeneralConversationCard!.bounds.height + self.TechnologyCard!.bounds.height + self.GardeningCard!.bounds.height + self.DatingCard!.bounds.height + self.EmergencyCard!.bounds.height + self.FamilyCard!.bounds.height);
        
        //        let scrollHeightSecond = Double(mathNumbersCard.bounds.height + schoolCard.bounds.height + shoppingCard.bounds.height + transportCard.bounds.height + travelCard.bounds.height + workCard.bounds.height);
        
        _masterScroll!.contentSize = CGSize.init(width: UIHelper.ScreenWidth, height: (scrollHeight + 100.0));
        
        
        //Floating Button
        self._floatBtn = Button.init(frame: CGRect(x: UIHelper.ScreenWidth - 90.0, y: UIHelper.ScreenHeight - 90.0, width: 70, height: 70));
        self._floatBtn!.backgroundColor = ColorHelper.LightOrange();
        self._floatBtn!.layer.cornerRadius = 35.0;
        self._floatBtn!.setImage(UIImage.init(named: ImageConstants._refreshIcon), for: UIControl.State.normal);
        self._floatBtn!.setImage(UIImage.init(named: ImageConstants._refreshIcon), for: UIControl.State.highlighted);
        self._floatBtn!.setImage(UIImage.init(named: ImageConstants._refreshIcon), for: UIControl.State.selected);
        self._floatBtn!.addTarget(self, action: #selector(RefreshButton), for: UIControl.Event.touchDown);
        
        //        floatButton.setImage(UIImage.init(named: Icon.check), for: UIControl.State.normal);
        //        floatButton.setImage(UIImage.init(named: Icon.check), for: UIControl.State.normal);
        //        floatButton.setImage(UIImage.init(named: Icon.check), for: UIControl.State.normal);
        
        isInitialized = true;
        self.view.addSubview(_masterScroll!);
        self.view.addSubview(self._floatBtn!);
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
