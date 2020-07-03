//
//  CardCategories.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 23/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Material;

internal final class CardCategories : Button {
    
    fileprivate var Category : PhraseCategories
    public var PhraseCount : String = "";
    
    var cardLabel: UILabel?;
    var cardBackground: UIImageView?;
    var overlay : UIView?;
    var buttonOverlay: Button?;
    
    var arrowOperator: UIImageView?;
    var countOfCardsLabel : UILabel?;
    
    override var frame: CGRect{
        didSet{
            ReconfigureCard(parentSize: self.bounds.size);
        }
    }
    
    init (category: PhraseCategories, frame: CGRect, _ countOfPhrases: Int) {
        Category = category;
        PhraseCount = "(\(String(countOfPhrases)))";
        
        super.init(frame: frame);
        
        ConfigureCardView(frame);
        SetTitleCard();
        SetCountOfCard();
        
        self.addTarget(self, action: #selector(NavigateToCategory), for: UIControl.Event.touchDown);
        //     ConfigureRippleOverlay(frame);
    }
    
    required init?(coder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        Category = PhraseCategories.GeneralConversation;
        
        super.init(coder: coder);
    }
    
    public func ReconfigureCard(parentSize : CGSize) {
        //Invoked by the parent controller to resize the elements
        if(self.cardLabel != nil){
        self.cardLabel!.frame = CGRect(x: 20.0, y: Double(self.frame.height - 50.0), width: Double(self.bounds.width), height: 50);
        self.cardBackground!.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 50);
        self.overlay!.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 50);
        self.arrowOperator!.frame = CGRect(x: Double(self.bounds.width - 50), y: 20.0, width: 40, height: 40);
        self.countOfCardsLabel?.frame = CGRect(x: Double(self.bounds.width - 60), y: Double(arrowOperator!.frame.maxY), width: 50, height: 50);
        }
    }
    
    public func ConfigureCardView(_ frame: CGRect) {
        //Graphics will be loaded up here
        self.layoutMargins = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10);
        self.backgroundColor = ColorHelper.Card_DarkThemeBackground();
        self.layer.cornerRadius = 20.0;
        self.borderColor = UIColor.lightGray;
        self.frame = frame;
        self.clipsToBounds = true;
    }
    
    fileprivate func SetTitleCard() {
        
        self.cardLabel = UILabel.init(frame: CGRect(x: 20.0, y: Double(self.frame.height - 50.0), width: Double(self.bounds.width), height: 50));
        
        self.cardLabel!.textColor = UIColor.white;
        self.cardLabel!.font = UIFont.init(name: "Roboto-Light", size: 32.0);
        self.cardLabel!.text = FriendlyNames.GetCategoryForNames(Category);
        
        
        //Card Background
        self.cardBackground = UIImageView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 50));
        self.cardBackground!.image = UIImage.init(named: FriendlyNames.GetBackgroundForCategory(Category));
        self.cardBackground!.contentMode = .scaleAspectFill;
        self.cardBackground!.isUserInteractionEnabled = false;
        
        //Dark Overlay of Card
        self.overlay = UIView.init(frame:CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 50));
        self.overlay!.backgroundColor = UIColor.black;
        self.overlay!.alpha = 0.4;
        self.overlay!.isUserInteractionEnabled = false;
        
        self.addSubview(self.cardBackground!);
        self.addSubview(self.overlay!);
        self.addSubview(self.cardLabel!);
    }
    
    fileprivate func ConfigureRippleOverlay(_ frame: CGRect) {
        
        self.buttonOverlay = Button.init(frame: frame);
        self.buttonOverlay!.backgroundColor = UIColor.clear;
        self.buttonOverlay!.pulseColor = UIColor.red;
        self.buttonOverlay!.addTarget(self, action: #selector(NavigateToCategory), for: UIControl.Event.touchUpInside);
        
        self.addSubview(self.buttonOverlay!);
        self.bringSubviewToFront(self.buttonOverlay!);
    }
    
    @objc fileprivate func NavigateToCategory(){
        NavigationHelper.NavigateToCategory(Category);
    }
    
    fileprivate func SetCountOfCard(){
        
        //Arrow Operator
        self.arrowOperator = UIImageView.init(frame: CGRect(x: Double(self.bounds.width - 50), y: 20.0, width: 40, height: 40));
        self.arrowOperator!.image = UIImage.init(named: ImageConstants._rightArrowIcon);
        self.arrowOperator!.isUserInteractionEnabled = false;
        
        self.countOfCardsLabel = UILabel.init(frame: CGRect(x: Double(self.bounds.width - 60), y: Double(arrowOperator!.frame.maxY), width: 50, height: 50));
        
        self.countOfCardsLabel!.textColor = UIColor.white;
        self.countOfCardsLabel!.font = UIFont.init(name: "Roboto-Light", size: 20.0)
        self.countOfCardsLabel!.text = PhraseCount;
        self.countOfCardsLabel!.isUserInteractionEnabled = false;
        
        self.addSubview(arrowOperator!);
        self.addSubview(self.countOfCardsLabel!);
    }
    
    
    //Public Apis
    public func SetCategory(_ category: PhraseCategories){
        Category = category;
    }
}

