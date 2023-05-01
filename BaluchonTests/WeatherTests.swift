//
//  WeatherTests.swift
//  BaluchonTests
//
//  Created by Zidouni on 01/05/2023.
//

import XCTest
@testable import Baluchon

class WeatherTests: XCTestCase {

    var weather: WeatherViewModel!
    
    override func setUp() {
        super.setUp()
        weather = WeatherViewModel()
    }
    
    func testGivenConvertStringToDate_WhenHavingStringInDateFormatWithYearMonthDayAndTimes_ThenPrintingTheDayTheDayAndTheYearsInFrench() {
        let input = "2023-05-03 13:04"
        let date = weather.convertStringToDate(from: input)
        
        XCTAssertTrue(date == "Mercredi 03 Mai")

    }
    
    func testGivenConvertStringToDate_WhenHavingStringInDateFormatWithYearMonthAndDays_ThenPrintingTheDayTheDayAndTheYearsInFrench() {
        let input = "2023-05-03"
        let date = weather.convertStringToDate(from: input)
        
        XCTAssertTrue(date == "Mercredi 03 Mai")

    }
    
    func testGivenConvertStringToDate_WhenHavingStringWhichIsntInDateFormat_ThenPrintingErrorMessage() {
        let input = "Hello world !"
        let date = weather.convertStringToDate(from: input)
        
        XCTAssertTrue(date == "We cannot convert this String to Date")

    }
    
    func testGivenConvertStringToHour_WhenHavingStringInDateFormatWithTimeAndTumeSystem_ThenPrintingTheTime() {
        let input = "02:04 PM"
        let date = weather.convertStringToHour(from: input)
        
        XCTAssertTrue(date == "14:04")

    }
    
    func testGivenConvertStringToHour_WhenHavingStringInDateFormatYearMonthDayAndTime_ThenPrintingTheTime() {
        let input = "2023-05-03 13:04"
        let date = weather.convertStringToHour(from: input)
        
        XCTAssertTrue(date == "13:04")

    }
    
    func testGivenConvertStringToHour_WhenHavingStringWhichIsntInDateFormat_ThenPrintingErrorMessage() {
        let input = "Hello world !"
        let date = weather.convertStringToHour(from: input)
        
        XCTAssertTrue(date == "We cannot convert this String to Date")

    }
}
