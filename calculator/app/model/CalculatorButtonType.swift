import UIKit

enum CalculatorButtonType: String{
    case PLUS = "+"
    case MINUS = "-"
    case MULTIPLY = "x"
    case DIVIDE = "÷"
    case PERCENTAGE = "%"
    case CLEAR = "AC"
    case EQUAL = "="
    case ZERO = "0"
    case ONE = "1"
    case TWO = "2"
    case THREE = "3"
    case FOUR = "4"
    case FIVE = "5"
    case SIX = "6"
    case SEVEN = "7"
    case EIGHT = "8"
    case NINE = "9"
    case COMMA = ","
    case TOGGLE = "+/-"
    
    var buttonColor: UIColor {
        switch self {
        case .PLUS, .MINUS, .MULTIPLY, .DIVIDE, .EQUAL :
            return UIColor(hex: "#FF331F")
        case .CLEAR, .TOGGLE,.PERCENTAGE:
            return UIColor(hex: "#657ED4")
        case .ZERO, .ONE, .TWO, .THREE, .FOUR, .FIVE, .SIX, .SEVEN, .EIGHT, .NINE, .COMMA:
            return UIColor(hex: "#3626A6")
        }
    }
    
    var symbol : String {
        switch self {
        case .COMMA:
            return "."
        default :
            return self.rawValue
        }
    }
}
