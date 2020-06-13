//
//  SWAPI_DbTests.swift
//  SWAPI.DbTests
//
//  Created by Assassin on 13/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import XCTest
@testable import SWAPI;

class SWAPI_DbTests: XCTestCase {

    var _dbService : DatabaseService = DatabaseService.init();
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetFilmsFromDbShouldBeEmpty() throws {
        XCTAssertEqual(_dbService.getFilmsCount(), 0, "SUCCESS: Films Count is 0");
    }
    
    func testGetFilmsFromDbShouldHaveValue() throws {
        
        let items = _dbService.getFilmsCount();
        XCTAssertTrue( items > 0, "SUCCESS: Database has stored \(items) films");
    }
    
    func testGetFilmsFromDbShouldHaveValueNoException() throws {
        XCTAssertNoThrow(_dbService.getFilmsCount());
    }
    
    func mapDto() -> FilmsResultDto{
        
        let film = FilmsResultDto.init(dictionary: ["":""]);
        film.director = "Unit Tested Director";
        film.producer = "This is the producer"
        film.title = "A successfully tested film";
        film.release_date = "1977-05-25";
        film.created = "2020-06-13";
        
        return film;
    }
    
    func testInsertFilmForDto() throws {
        XCTAssertNoThrow(_dbService.insertFilm(dto: self.mapDto()));
    }
}
