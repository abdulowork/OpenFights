//
// Created by Артмеий Шлесберг on 16/06/2017.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation

extension String {

    var trim: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces.union(CharacterSet(charactersIn: "\n")))
    }

    var url: URL? {

        return URL(string: self)
    }

    var phone: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    }

    func convertedOnEmpty(to string: String) -> String {
        if self.isEmpty { return string } else { return self }
    }
    
    func convertedOnEmptyToNil() -> String? {
        if self.isEmpty { return nil } else { return self }
    }

}

extension String {

    subscript (i: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: i)
        return self.characters[index]
    }

    func replaceNumbers() -> String {
        var result = ""
        for char in self.characters {
            switch char {
            case "0": result.append("O")
            case "1": result.append("I")
            case "2": result.append("S")
            case "3": result.append("S")
            case "4": result.append("A")
            case "5": result.append("S")
            case "6": result.append("G")
            case "7": result.append("Z")
            case "8",
                 "9": result.append("B")

            default: result.append(char)
            }
        }

        return result
    }

    func replaceLetters() -> String {
        var result = ""
        for char in self.characters {
            switch char {
            case "O",
                 "D": result.append("0")

            case "I",
                 "L": result.append("1")

            case "S": result.append("5")
            case "A": result.append("4")
            case "G": result.append("6")
            case "Z": result.append("7")
            case "B": result.append("8")

            default: result.append(char)
            }
        }

        return result
    }
}

extension Optional {

    func unwrapOrThrow() throws -> Wrapped {
        guard let unwrapped = self else { throw NSError(domain: "Can't unwrap", code: 404) }
        return unwrapped
    }

}
