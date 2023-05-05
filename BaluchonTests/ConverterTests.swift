//
//  ConverterTests.swift
//  ConverterTests
//
//  Created by Zidouni on 03/04/2023.
//

import XCTest
import Combine
@testable import Baluchon


class ConverterTests: XCTestCase {
    
    var converter: ConverterViewModel!
    var cancellables = Set<AnyCancellable>()
    var envPlistPath: String!
    var originalEnvPlist: NSDictionary!
    
    override func setUp() {
        super.setUp()
        converter = ConverterViewModel()
        
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
    
    func testGivenFetchExchangeRates_WhenHavingBaseAndConvertCurrency_ThenPrintingTheExchangeRate() {
        let expectation = XCTestExpectation(description: "Fetch Exchange Rate")
        let baseCurrency = "USD"
        let convertCurrency = "EUR"
        
        converter.getExchangeRate(from: baseCurrency, to: convertCurrency) { _ in }
        
        converter.$exchangeRateAvailable
            .dropFirst()
            .sink { available in
                if available {
                    XCTAssertNotNil(self.converter.exchangeRate)
                    XCTAssertNotNil(self.converter.exchangeRates["\(baseCurrency) to \(convertCurrency)"])
                    XCTAssertNotNil(self.converter.exchangeRates["\(convertCurrency) to \(baseCurrency)"])
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGivenFetchExchangesRates_WhenAlreadyHaveExchangesRates_ThenPrintingError() {
        let baseCurrency = "USD"
        let convertCurrency = "EUR"
        var errorMessage: String?
        
        converter.exchangeRates = ["\(baseCurrency) to \(convertCurrency)" : "1.11"]
        
        let expectation = XCTestExpectation(description: "Get exchange rate")
        
        converter.getExchangeRate(from: baseCurrency, to: convertCurrency) { result in
            switch result {
            case .success:
                print("Success")
            case .failure(let error):
                errorMessage = error.errorDescription
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(errorMessage, "You already have the exchange rate for this currency")
    }
    
    func testGivenFetchExchangesRates_WhenAPIKeyIsUndefined_ThenPrintingError() {
        let envFile = "Env_test"
        var errorMessage: String?
        
        converter.getExchangeRate(from: "EUR", to: "USD", apiKeyFileName: envFile) { result in
            switch result {
            case .success:
              print("Success")
            case .failure(let error):
                errorMessage = error.errorDescription
            }
        }
        XCTAssertEqual(errorMessage, "Your APIKey was not found")
    }
    
    func testGivenFetchExchangesRates_WhenBaseOrConvertCurrencyIsInvalid_ThenPrintingError() {
        let expectation = XCTestExpectation(description: "Invalid Currency Parameters")
        converter.getExchangeRate(from: "EUR", to: "XYZ") { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertEqual(error.errorDescription, "Your base currency or convert currency is invalid")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGivenFetchExchangesRates_WhenAPIKeyIsInvalid_ThenPrintingError() {
        let expectation = XCTestExpectation(description: "Invalid API Key")

        guard let envPlistPath = Bundle.main.path(forResource: "Env", ofType: "plist") else {
            XCTFail("The Env.plist file does not exist")
            return
        }
        
        var envPlist = NSMutableDictionary(contentsOfFile: envPlistPath) as? [String: Any]

        envPlist?["CONVERTER_API_KEY"] = "1234"

        (envPlist as NSDictionary?)?.write(toFile: envPlistPath, atomically: true)
        converter.getExchangeRate(from: "EUR", to: "USD") { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertEqual(error.errorDescription, "Access denied, please check your API Key")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
   
    func testGivenConvertedAmount_WhenHavingAmountAndRate_ThenPrintingConvertedAmountInStringWithTwoNumberAfterTheDot() {
        var convertedAmount = ""
        convertedAmount = converter.calculConvertedAmount(amount: "20", rate: "1.10")
        
        XCTAssertTrue(convertedAmount == "22.00")
    }
    
    func testGivenConvertedAmount_WhenHavingWordForAmount_ThenReplaceAmountBy0() {
        var convertedAmount = ""
        convertedAmount = converter.calculConvertedAmount(amount: "Hello", rate: "1.10")
        
        XCTAssertTrue(convertedAmount == "0.00")
    }
    
    func testGivenValidateCurrencyInput_WhenTryingToEnterLetterInInput_ThenRemoveLetter() {
        var validateInput = "Hell,34o"
        validateInput = converter.validateCurrencyInput(validateInput)
        
        XCTAssertTrue(validateInput == "0.34")
    }
    
    func testGivenValidateCurrencyInput_WhenEnterNumberWithCommaInInput_ThenReplaceCommaByADot() {
        var validateInput = "12,4"
        validateInput = converter.validateCurrencyInput(validateInput)
        
        XCTAssertTrue(validateInput == "12.4")
    }
    
    func testGivenValidateCurrencyInput_WhenEnterDecimalNumberAndTryingToEnterAnAnotherDot_ThenPrintingTheDecimalNumberWithOnlyOneDotAndTwoNumberAfterIt() {
        var validateInput = "42,45,63"
        validateInput = converter.validateCurrencyInput(validateInput)

        XCTAssertTrue(validateInput == "42.45")
    }
}
