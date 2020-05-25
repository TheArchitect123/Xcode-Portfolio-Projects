//
//  CardCategories.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 23/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Material;

internal final class CardCategories : UIView {
    
    fileprivate var Category : PhraseCategories
    public var PhraseCount : String = "(30)";
    
    init (category: PhraseCategories, frame: CGRect) {
        Category = category;
        
        super.init(frame: frame);
        
        ConfigureCardView(frame);
        SetTitleCard();
        SetCountOfCard();
        ConfigureRippleOverlay();
    }
    
    required init?(coder: NSCoder) {
       // fatalError("init(coder:) has not been implemented")
        Category = PhraseCategories.GeneralConversation;
        
        super.init(coder: coder);
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
        
        let titleLabel : UILabel = UILabel.init(frame: CGRect(x: 20.0, y: Double(self.frame.height - 50.0), width: Double(self.bounds.width), height: 50));
        
        titleLabel.textColor = UIColor.white;
        titleLabel.font = UIFont.init(name: "Roboto-Light", size: 32.0)
        titleLabel.text = FriendlyNames.GetCategoryForNames(Category);
        
        
        //Card Background
        let cardBackground = UIImageView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 50));
        cardBackground.image = UIImage.init(named: FriendlyNames.GetBackgroundForCategory(Category));
        cardBackground.contentMode = .scaleAspectFill;
        
        //Dark Overlay of Card
        let overlay : UIView = UIView.init(frame:CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 50));
        overlay.backgroundColor = UIColor.black;
        overlay.alpha = 0.4;
        
        self.addSubview(cardBackground);
        self.addSubview(overlay);
        self.addSubview(titleLabel);
    }
    
    fileprivate func ConfigureRippleOverlay() {
        
        let buttonOverlay : Button = Button.init(frame: self.frame);
        buttonOverlay.backgroundColor = UIColor.clear;
        buttonOverlay.pulseColor = UIColor.red;
        buttonOverlay.addTarget(self, action: #selector(NavigateToCategory), for: UIControl.Event.touchDown);
        
        
        
        self.addSubview(buttonOverlay);
        self.bringSubviewToFront(buttonOverlay);
    }
    
   @objc fileprivate func NavigateToCategory(){
        NavigationHelper.NavigateToCategory(Category);
    }
    
    fileprivate func SetCountOfCard(){
        
        //Arrow Operator
            let arrowOperator = UIImageView.init(frame: CGRect(x: Double(self.bounds.width - 50), y: 20.0, width: 40, height: 40));
        arrowOperator.image = UIImage.init(named: ImageConstants._rightArrowIcon);
            
        
        let countOfCardsLabel : UILabel = UILabel.init(frame: CGRect(x: Double(self.bounds.width - 60), y: Double(arrowOperator.frame.maxY), width: 50, height: 50));
        
               countOfCardsLabel.textColor = UIColor.white;
               countOfCardsLabel.font = UIFont.init(name: "Roboto-Light", size: 20.0)
        countOfCardsLabel.text = PhraseCount;
        
    
        self.addSubview(arrowOperator);
        self.addSubview(countOfCardsLabel);
    }
    
    
    //Public Apis
    public func SetCategory(_ category: PhraseCategories){
        Category = category;
    }
}

