//
//  JustEatTests.swift
//  JustEatTests
//
//  Created by Philippa Day on 12/02/2021.
//

import XCTest
@testable import JustEat

class JustEatTests: XCTestCase {

    var systemUnderTest: ViewController!
    var restaurant: Restaurant?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        //get the storyboard the ViewController under test is inside
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        //get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
        systemUnderTest = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        restaurant = Restaurant(name: "TEST", ratingStars: 20, logoURL: "https://fakeURL.com")

        //load view hierarchy
        _ = systemUnderTest.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRestaurantName() {
        XCTAssertTrue(restaurant?.name == "TEST", "Fail, name incorrect")
    }

    func testRestaurantRating() {
        XCTAssertTrue(restaurant?.ratingStars == 20, "Fail, rating incorrect")
    }

    func testRestaurantUrl() {
        XCTAssertTrue(restaurant?.logoURL == "https://fakeURL.com", "Fail, logoURL incorrect")
    }


    func testSUT_HasSearchBar() {
        XCTAssertNotNil(systemUnderTest.searchBar)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
