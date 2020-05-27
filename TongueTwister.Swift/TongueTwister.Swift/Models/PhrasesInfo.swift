//
//  PhrasesInfo.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 26/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Unbox;
import JSONParserSwift;

internal class PhrasesInfo : ParsableModel {

    public var Category : Int = 0;
    public var EnglishPhrase : String = "";
    public var FrenchPhrase : String = "";
}
