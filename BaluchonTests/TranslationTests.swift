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
    var translationNoConnection: TranslationViewModel!
    var envPlistPath: String!
    var originalEnvPlist: NSDictionary!
    
    override func setUp() {
        super.setUp()
        translation = TranslationViewModel()
        translationNoConnection = TranslationViewModel(connectionManager: NoConnectionManager())
        
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
    
    func testGivenTranslateText_WhenHavingAllRightParameters_ThenTranslateTheTextInTargetLanguage() {
        let textToTranslate = "Ceci est un test"
        let expectation = XCTestExpectation(description: "Translation Completed")
        var translatedText = ""

        translation.translateText(textToTranslate, source: "fr", target: "en") { result in
            switch result {
            case .success (let response):
                translatedText = response.data.translations.first?.translatedText ?? ""
            case .failure:
                XCTFail("There are an error")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(translatedText, "this is a test")
    }
    
    func testGivenTranslateText_WhenOneOfTheParametersIsInvalid_ThenPrintingError() {
        let textToTranslate = "Ceci est un test"
        
        let expectation = XCTestExpectation(description: "Invalid Parameters")
        translation.translateText(textToTranslate, source: "f", target: "en") { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertEqual(error.errorDescription, "One of your parameters is invalid")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
      
    func testGivenTranslateText_WhenAPIKeyIsUndefined_ThenPrintingError() {
        let envFile = "Env_test"
        let textToTranslate = "Ceci est un test"
        
        translation.translateText(textToTranslate, source: "fr", target: "en", apiKeyFileName: envFile) { result in
            switch result {
            case .success:
               print("Success")
            case .failure(let error):
                XCTAssertEqual(error.errorDescription, "Your APIKey was not found")
            }
        }
    }
    
    func testGivenTranslateText_WhenConnectionIsCut_ThenPrintingError() {
        let textToTranslate = "Ceci est un test"
        
        translationNoConnection.translateText(textToTranslate, source: "fr", target: "en")  { result in
            switch result {
            case .success(_):
                print("Success")
            case .failure(let error):
                XCTAssertEqual(error.errorDescription, "We can't load data, please check your connection")
            }
        }
    }
    
    func testGivenGetExchangeRate_WhenTryingToParseData_ThenReceiveExchangeRate() throws {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "TranslationData", ofType: "json") else {
            XCTFail("JSON file not found.")
            return
        }
        
        let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
        
        do {
            let decoder = JSONDecoder()
            let translation = try decoder.decode(TranslationResponse.self, from: jsonData)
            
            XCTAssertEqual(translation.data.translations[0].translatedText, "This is a test")
            
        } catch {
            XCTFail("Error parsing JSON: \(error)")
        }
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
