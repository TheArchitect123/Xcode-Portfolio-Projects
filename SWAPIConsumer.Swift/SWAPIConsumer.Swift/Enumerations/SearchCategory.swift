//
//  SearchCategory.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//


///Search category of items that users can search for -- each one of these categories will be mapped to a friendly name function, which will bind itself to the url for the rest call
enum SearchCategory : Int {
    case films = 0;
    case people = 1;
    case planets = 2;
    case species = 3;
    case starships = 4;
    case vehicles = 5
}
