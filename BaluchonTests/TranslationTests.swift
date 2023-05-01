//
//  TranslationTests.swift
//  BaluchonTests
//
//  Created by Zidouni on 01/05/2023.
//

import XCTest
@testable import Baluchon

class TranslationTests: XCTestCase {

    var translation: TranslationViewModel!
    
    override func setUp() {
        super.setUp()
        translation = TranslationViewModel()
    }
    
    
    func testGivenCopyClipboard_WhenUserClickOnCopyButton_ThenCopyTheCurrentTextToTheClipboard() {
        let textCopied = translation.copyToClipboard(text: "Hello world !")
        
        XCTAssertTrue(textCopied == true)
    }
    
    func testGivenPasteClipboard_WhenUserClickOnPasteButtin_ThenPasteTheCurrentCiploboardToTheTextField() {
        var textField = ""
        textField = translation.pasteToClipBoard(text: "Hello world !")
        
        XCTAssertTrue(textField == "Hello world !")
    
    }

}
