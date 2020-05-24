//
//  FriendlyNames.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 24/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation

internal struct FriendlyNames {
    
    internal static func GetCategoryForNames(_ category: PhraseCategories) -> String {
        switch category {
        case PhraseCategories.GeneralConversation:
            return "General Conversation";
        case PhraseCategories.Gardening:
            return "Gardening";
        case PhraseCategories.Dating:
            return "Dating";
        case PhraseCategories.Emergency:
            return "Emergency";
        case PhraseCategories.Family:
            return "Family";
        case PhraseCategories.FirstTimeMeeting:
            return "First Time Meeting";
        case PhraseCategories.Food:
            return "Food";
        case PhraseCategories.MathNumbers:
            return "Math & Numbers";
        case PhraseCategories.School:
            return "School & Education";
        case PhraseCategories.Shopping:
            return "Shopping";
        case PhraseCategories.Technology:
            return "Technology";
        case PhraseCategories.Transport:
            return "Transport";
        case PhraseCategories.Travel:
            return "Travel";
        case PhraseCategories.Work:
            return "Work";
            
        default:
            return "";
        }
    }
}
