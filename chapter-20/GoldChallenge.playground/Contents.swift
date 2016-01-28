//: Playground - noun: a place where people can play

import Cocoa

enum Token {
    case Number(Int)
    case Plus
    case Minus
    case Multiply
    case Divide
}

class Lexer {
    
    enum Error: ErrorType {
        case InvalidCharacter(Character)
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
            switch nextCharacter {
            case "0"..."9":
                let value = getNumber()
                tokens.append(.Number(value))
                
            case "+":
                tokens.append(.Plus)
                advance()
                
            case "-":
                tokens.append(.Minus)
                advance()
                
            case "*":
                tokens.append(.Multiply)
                advance()
            
            case "/":
                tokens.append(.Divide)
                advance()
                
            case " ":
                // Just advance to ignore spaces
                advance()
                
            default:
                // Something unexpected - need to send back an error
                throw Error.InvalidCharacter(nextCharacter)
            }
        }
        return tokens
    }
}

class Parser {
    enum Error: ErrorType {
        case UnexpectedEndOfInput
        case InvalidToken(Token)
        case PositionIndexOutOfRange(Int)
        case ProductOrQuotientExpressionOutOfRange(Range<Int>)
    }
    
    // change tokens array to mutable for Gold Challenge
    //let tokens: [Token]
    var tokens: [Token]
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
        case .Number(let value):
            return value
            
        case .Plus, .Minus, .Multiply, .Divide:
            throw Error.InvalidToken(token)
        }
    }
    
    
    func parse() throws -> Int {
        
        /*
            Helper function that replaces the three tokens in tokens array, represented by
            
            ( .Number(firstOperand) .Multiply .Number(secondOperand) )
                                        OR
            ( .Number(firstOperand) .Divide .Number(secondOperand) )
            
            with a new token ( result ) that represents the corresponding
            quotient or product:
            
            .Number( firstOperand * secondOperand )
                                OR
            .Number( firstOperand / secondOperand )
        
        
            ** NOTE: tokens[position] is assumed to return the element one past the secondOperand
            token ( unless position == tokens.count ) when this method is called.
        */
        func replaceQuotientOrProductTokensWithResult(result: Token) throws {
            
            // make sure range is valid
            guard position - 3 >= 0 && position - 1 < tokens.count else {
                throw Error.ProductOrQuotientExpressionOutOfRange((position-3)...(position-1))
            }
            
            let expressionRange = (position - 3)...(position - 1)
            tokens.replaceRange(expressionRange, with: [result])
            
            // reset position to the index of result
            position -= 3
            guard position >= 0 else {
                throw Error.PositionIndexOutOfRange(position)
            }
        }
        func replaceDivisionExpressionTokensWithQuotient(quotient: Token) throws {
            try replaceQuotientOrProductTokensWithResult(quotient)
        }
        func replaceMultiplicationExpressionTokensWithProduct(product: Token) throws {
            try replaceQuotientOrProductTokensWithResult(product)
        }
        
        func performMultiplicationAndDivisionOperations() throws {
            
            // Require a number first
            var number = try getNumber()
            
            
            while let token = getNextToken() {
                switch token {
                    
                    // Ignore, move on to next number
                case .Plus, .Minus:
                    number = try getNumber()
                    
                    // Getting a Number after a Number is not legal
                case .Number:
                    throw Error.InvalidToken(token)
                    
                case .Multiply:
                    let nextNumber = try getNumber()
                    let newToken = Token.Number(number * nextNumber)
                    
                    try replaceMultiplicationExpressionTokensWithProduct(newToken)
                    
                    number = try getNumber()
                    
                case .Divide:
                    let nextNumber = try getNumber()
                    let newToken = Token.Number(number / nextNumber)
                    
                    try replaceDivisionExpressionTokensWithQuotient(newToken)
                    
                    number = try getNumber()
                }
            }
            
            // reset position to beginning of token array
            position = tokens.startIndex
        }
        
        func performAdditionAndSubtractionOperations() throws -> Int {
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
                case .Number:
                    throw Error.InvalidToken(token)
                    
                    // Ignore: multiplication and division operations should already have
                    // been performed due to higher precedence
                case .Multiply, .Divide:
                    print("ERROR: multiplication or division expression not evaluated!")
                    throw Error.InvalidToken(token)
                }
            }
            return value
        }
        
        try performMultiplicationAndDivisionOperations()
        return try performAdditionAndSubtractionOperations()
    }
}

func evaluate(input: String) {
    print("Evaluating: \(input)")
    let lexer = Lexer(input: input)
    
    do {
        let tokens = try lexer.lex()
        print("Lexer output: \(tokens)")
        
        let parser = Parser(tokens: tokens)
        let result = try parser.parse()
        print("Parser output: \(result)")
        
    } catch Lexer.Error.InvalidCharacter(let character) {
        print("Input contained an invalid character: \(character)")
    } catch Parser.Error.UnexpectedEndOfInput {
        print("Unexptected end of input during parsing")
    } catch Parser.Error.InvalidToken(let token) {
        print("Invalid token during parsing: \(token)")
    } catch {
        print("An error occurred: \(error)")
    }
}


evaluate("10 * 3 + 5 * 3")
//evaluate("10 + 3 * 5 + 3")
//evaluate("10 + 3 * 5 * 3")




