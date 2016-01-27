/*
    SILVER CHALLENGE

    I solved this challenge by adding associated values to the Token enumeration cases in
    order to track indices.

    Additional associated values ( for index ) were added to the Error types defined 
    in Lexer and Parser.

    Probably a more elegant solution, but I'll leave this up here for the time being...

*/

import Cocoa

enum Token {
    case Number(value: Int, index: String.CharacterView.Index)
    case Plus(index: String.CharacterView.Index)
    case Minus(index: String.CharacterView.Index)
}

class Lexer {
    
    enum Error: ErrorType {
        case InvalidCharacter(char: Character, index: String.CharacterView.Index)
    }
    
    let input: String.CharacterView
    var position: String.CharacterView.Index
    
    init(input: String) {
        self.input = input.characters
        self.position = self.input.startIndex
    }
    
    func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }
    
    func advance() {
        assert(position < input.endIndex, "Cannot advance past the end!")
        ++position
    }
    
    func getNumber() -> Int {
        var value = 0
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0"..."9":
                // Another digit - add it into value
                let digitValue = Int(String(nextCharacter))!
                
                value = 10 * value + digitValue
                advance()
                
            default:
                // A non-digit - go back to regular lexing
                return value
            }
        }
        return value
    }
    
    func lex() throws -> [Token] {
        var tokens = [Token]()
        
        while let nextCharacter = peek() {
            
            let nextCharacterPosition = position
            
            switch nextCharacter {
            case "0"..."9":
                let value = getNumber()
                tokens.append(.Number(value: value, index: nextCharacterPosition))
                
            case "+":
                tokens.append(.Plus(index: nextCharacterPosition))
                advance()
                
            case "-":
                tokens.append(.Minus(index: position))
                advance()
                
            case " ":
                // Just advance to ignore spaces
                advance()
                
            default:
                // Something unexpected - need to send back an error
                throw Error.InvalidCharacter(char: nextCharacter, index: position)
            }
        }
        return tokens
    }
}

class Parser {
    enum Error: ErrorType {
        case UnexpectedEndOfInput
        case InvalidToken(token: Token, index: String.CharacterView.Index)
    }
    
    let tokens: [Token]
    var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        return tokens[position++]
    }
    
    func getNumber() throws -> Int {
        guard let token = getNextToken() else {
            throw Error.UnexpectedEndOfInput
        }
        
        switch token {
        case .Number(let value, _):
            return value
            
        case .Plus(let index):
            throw Error.InvalidToken(token: token, index: index)
            
        case .Minus(let index):
            throw Error.InvalidToken(token: token, index: index)
        }
    }
    
    func parse() throws -> Int {
        // Require a number first
        var value = try getNumber()
        
        while let token = getNextToken() {
            switch token {
                // Getting a Plus after a Number is legal
            case .Plus:
                // After a plus, we must get another number
                let nextNumber = try getNumber()
                value += nextNumber
                
                // Getting a Minus after a Number is legal
            case .Minus:
                let nextNumber = try getNumber()
                value -= nextNumber
                
                // Getting a Number after a Number is not legal
            case .Number(_, let index):
                throw Error.InvalidToken(token: token, index: index)
            }
        }
        return value
    }
}

func evaluate(input: String) {
    print("Evaluating: \(input)")
    let lexer = Lexer(input: input)
    //let tokens = try! lexer.lex()
    
    do {
        let tokens = try lexer.lex()
        print("Lexer output: \(tokens)")
        
        let parser = Parser(tokens: tokens)
        let result = try parser.parse()
        print("Parser output: \(result)")
        
    } catch Lexer.Error.InvalidCharacter(let character, let index) {
        print("Input contained an invalid character at index \(index): \(character)")
    } catch Parser.Error.UnexpectedEndOfInput {
        print("Unexpected end of input during parsing")
    } catch Parser.Error.InvalidToken(let token, let index) {
        print("Invalid token during parsing at index \(index): \(token)")
    } catch {
        print("An error occurred: \(error)")
    }
}

//evaluate("10 + 3 + 5")
//evaluate("10 + 5 - 3 - 1")

//evaluate("1 + 3 + 7a + 8")
evaluate("10 + 3  3 + 7")