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
    var envPlistPath: String!
    var originalEnvPlist: NSDictionary!
    
    override func setUp() {
        super.setUp()
        weather = WeatherViewModel()
        
        let fileManager = FileManager.default
        envPlistPath = Bundle.main.path(forResource: "Env", ofType: "plist")!
        originalEnvPlist = NSDictionary(contentsOfFile: envPlistPath)
        try? fileManager.copyItem(atPath: envPlistPath, toPath: envPlistPath + ".backup")
    }
    
    override func tearDown() {
           super.tearDown()
        
           let fileManager = FileManager.default
           try? fileManager.removeItem(atPath: envPlistPath)
           try? fileManager.moveItem(atPath: envPlistPath + ".backup", toPath: envPlistPath)
       }
    
    func testGetWeather_WhenHavingAllRightParameters_ThenDisplayWeatherOfLocationParameter() {
        let expectation = XCTestExpectation(description: "Weather Completed")
        
        weather.getWeather(for: "Paris") { result in
            switch result {
            case .success (let response):
                XCTAssertEqual(response.location.name, "Paris")
                XCTAssertEqual(response.location.region, "Ile-de-France")
                XCTAssertEqual(response.location.country, "France")
            case .failure:
                XCTFail("There are an error")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetWeather_WhenOneOfTheParametersIsInvalid_ThenPrintingError() {
        let expectation = XCTestExpectation(description: "Invalid Parameters")
        
        weather.getWeather(for: "P") { result in
            switch result {
            case .success:
                print("Success")
            case .failure(let error):
                XCTAssertEqual(error.errorDescription, "One of your parameters is invalid")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetWeather_WhenAPIKeyIsUndefined_ThenPrintingError() {
        let envFile = "Env_test"

        weather.getWeather(for: "Paris", apiKeyFileName: envFile) { result in
            switch result {
            case .success:
                print("Success")
            case .failure (let error):
                XCTAssertEqual(error.errorDescription, "Your APIKey was not found")
            }
        }
    }
    
    func testGetWeather_WhenAPIKeyIsInvalid_ThenPrintingError() {
        let expectation = XCTestExpectation(description: "Invalid API Key")

        guard let envPlistPath = Bundle.main.path(forResource: "Env", ofType: "plist") else {
            XCTFail("The Env.plist file does not exist")
            return
        }
        
        var envPlist = NSMutableDictionary(contentsOfFile: envPlistPath) as? [String: Any]

        envPlist?["WEATHER_API_KEY"] = "1234"

        (envPlist as NSDictionary?)?.write(toFile: envPlistPath, atomically: true)
        weather.getWeather(for: "Paris") { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertEqual(error.errorDescription, "Access denied, please check your API Key")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
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
