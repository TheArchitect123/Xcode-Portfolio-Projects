//
//  PhrasesInfo.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 26/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Unbox;

internal struct PhrasesInfo : Unboxable {
    init(unboxer: Unboxer) throws {
        self.Category = try unboxer.unbox(key: "Category");
        self.EnglishPhrase = try unboxer.unbox(key: "EnglishPhrase");
        self.FrenchPhrase = try unboxer.unbox(key: "FrenchPhrase");
    }
    
    public var Category : Int;
    public var EnglishPhrase : String;
    public var FrenchPhrase : String;
}
