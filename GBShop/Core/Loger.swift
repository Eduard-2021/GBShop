//
//  Loger.swift
//  GBShop
//
//  Created by Eduard on 26.12.2021.
//

import Foundation

struct LogMessage: ExpressibleByStringLiteral {
    
    let message: String
    
    init(stringLiteral value: String) {
        self.message = value
    }
}

extension LogMessage {
    static var funcStart: LogMessage { "-->" }
    static var funcEnd: LogMessage { "<--" }
    static var call: LogMessage { "--" }
}

func logging(_ logInstance: Any, file: String = #file, funcName: String = #function, line: Int = #line) {
    let logMessage = "\(Date()): \(file) \(funcName) \(line): \(logInstance)\n"
    
    let file = "file.txt"

    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let path = dir.appendingPathComponent(file)

        do {
            try logMessage.appendToURL(fileURL: path)
        }
        catch let error {
           print("Ошибка при записи в файл логирования! Код: \(error)")}
    }
}

func logging(_ logInstance: LogMessage, file: String = #file, funcName: String = #function, line: Int = #line) {
    logging(logInstance.message, funcName: funcName, line: line)
}

extension String {
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

extension Data {
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}
