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
    
    internal static func GetBackgroundForCategory(_ category: PhraseCategories) -> String {
          switch category {
          case PhraseCategories.GeneralConversation:
            return ImageConstants._generalConversationBackground;
          case PhraseCategories.Gardening:
              return ImageConstants._gardeningBackground;
          case PhraseCategories.Dating:
              return ImageConstants._datingBackground;
          case PhraseCategories.Emergency:
              return ImageConstants._emergencyBackground;
          case PhraseCategories.Family:
              return ImageConstants._familyBackground;
          case PhraseCategories.FirstTimeMeeting:
              return ImageConstants._firstTimeMeetingBackground;
          case PhraseCategories.Food:
              return ImageConstants._foodBackground;
          case PhraseCategories.MathNumbers:
              return ImageConstants._mathNumbersBackground;
          case PhraseCategories.School:
              return ImageConstants._schoolBackground;
          case PhraseCategories.Shopping:
              return ImageConstants._shoppingBackground;
          case PhraseCategories.Technology:
              return ImageConstants._technologyBackground;
          case PhraseCategories.Transport:
              return ImageConstants._transportBackground;
          case PhraseCategories.Travel:
              return ImageConstants._travelBackground;
          case PhraseCategories.Work:
              return ImageConstants._workBackground;
          }
      }
}
