//
//  ConverterTests.swift
//  ConverterTests
//
//  Created by Zidouni on 03/04/2023.
//

import XCTest
@testable import Baluchon

class ConverterTests: XCTestCase {

    var converter: ConverterViewModel!
    
    override func setUp() {
        super.setUp()
        converter = ConverterViewModel()
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


