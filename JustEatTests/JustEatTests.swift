//
//  JustEatTests.swift
//  JustEatTests
//
//  Created by Philippa Day on 12/02/2021.
//

import XCTest
@testable import JustEat

class JustEatTests: XCTestCase {

    var restaurant: Restaurant?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        restaurant = Restaurant(name: "TEST", ratingStars: 20, typeOfFood: [Cuisines(name: "TESTFOOD")], logoURL: "https://fakeURL.com")

        //load view hierarchy
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

    func testRestaurantCuisine() {
        XCTAssertTrue(restaurant?.typeOfFood?[0].name == "TESTFOOD", "Fail, cuisine incorrect")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
