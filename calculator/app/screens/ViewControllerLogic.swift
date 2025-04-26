import UIKit

extension ViewController {
    
    func calculatorButtonTapped(calculatorButtonType : CalculatorButtonType) {
        switch calculatorButtonType {
            
        case .ZERO, .ONE, .TWO, .THREE, .FOUR, .FIVE, .SIX, .SEVEN, .EIGHT, .NINE,.COMMA:
            actions.append(calculatorButtonType.symbol);
            resultLabel.text = self.mapActionsWithDot(actions: self.actions)
            
        case .PLUS, .MINUS, .MULTIPLY, .DIVIDE :
            let lastElement :String? = actions.last;
            if(lastElement == nil || (lastElement != nil && self.isOperator(action: lastElement!))){
                break;
            }
            actions.append(calculatorButtonType.symbol);
            resultLabel.text = self.mapActionsWithDot(actions: self.actions)
        
        case .CLEAR :
            actions.removeAll()
            resultLabel.text = CalculatorButtonType.ZERO.symbol

        case .EQUAL :
            let mergedActions = self.mergeActions()
            let resultAsDot = self.calculateEqualResult(actions: mergedActions)
            let resultAsComma : String = resultAsDot.replacingOccurrences(of: CalculatorButtonType.COMMA.symbol, with: CalculatorButtonType.COMMA.rawValue)
            actions.removeAll()
            actions.append(resultAsComma)
            resultLabel.text = resultAsComma

        case .PERCENTAGE :
            let mergedActions = self.mergeActions()
            self.actions = self.calculatePercentage(actions: mergedActions)
            resultLabel.text = self.mapActionsWithDot(actions: self.actions)
            
        case .TOGGLE :
            let mergedActions = self.mergeActions()
            self.actions = self.toggleSign(actions: mergedActions)
            resultLabel.text = self.mapActionsWithDot(actions: self.actions)
        }
        print("actions -> \(actions)")
    }
    
    private func isOperator(action: String) -> Bool {
        return [
            CalculatorButtonType.PLUS,
            CalculatorButtonType.MINUS,
            CalculatorButtonType.MULTIPLY,
            CalculatorButtonType.DIVIDE
        ]
        .map {$0.symbol}
        .contains(action)
    }

    private func mapActionsWithDot(actions: [String]) -> String {
        return actions
            .joined(separator: "")
            .replacingOccurrences(of: CalculatorButtonType.COMMA.symbol, with: CalculatorButtonType.COMMA.rawValue)
    }
    
    
    private func mergeActions() -> [String] {
        var mergedActions: [String] = []
        var currentNumber : String = ""
        var dotMode: Bool = false
        
        for action in actions {
            if action == CalculatorButtonType.COMMA.symbol {
                if dotMode {
                    return ["0"]
                }
                dotMode = true
                currentNumber += CalculatorButtonType.COMMA.symbol
            }else if Double(action) != nil{
                currentNumber += action
            }else{
                if !currentNumber.isEmpty{
                    mergedActions.append(currentNumber)
                    currentNumber = ""
                    dotMode = false
                }
                mergedActions.append(action)
            }
        }
        
        if !currentNumber.isEmpty{
            mergedActions.append(currentNumber)
        }
        
        return mergedActions
    }

    private func calculateEqualResult(actions : [String]) -> String {
        var workingActions = actions
        
        var index = 0

        while index < workingActions.count {
            let currentAction = workingActions[index]
            
            if currentAction == CalculatorButtonType.MULTIPLY.symbol || currentAction == CalculatorButtonType.DIVIDE.symbol {
                
                guard let left = Decimal(string: workingActions[index - 1]),
                      let right = Decimal(string: workingActions[index + 1]) else {
                    return "0"
                }
                
                let result: Decimal
                if currentAction == CalculatorButtonType.MULTIPLY.symbol {
                    result = left * right
                } else {
                    if right == 0 {
                        self.showZeroDividerAlert()
                        return "0"
                    }
                    result = left / right
                }
                workingActions.replaceSubrange(index-1...index+1, with: [String(describing: result)])
                //index = max(index - 1 , 0)
            }else {
                index += 1
            }
        }
        
        index = 0
        while index < workingActions.count {
            let currentAction = workingActions[index]
            
            if currentAction == CalculatorButtonType.PLUS.symbol || currentAction == CalculatorButtonType.MINUS.symbol {
                
                guard let left = Decimal(string:workingActions[index - 1]),
                      let right = Decimal(string:workingActions[index + 1]) else {
                    return "0"
                }
                
                let result = currentAction == CalculatorButtonType.PLUS.symbol ? left + right : left - right
                workingActions.replaceSubrange(index-1...index+1, with: [String(describing: result)])
                //index = max(index - 1 , 0)
            }else{
                index += 1
            }
        }
        
        if(workingActions.first != nil){
            return self.formatDecimalString(value: workingActions.first!)
        }
        
        return "0"
    }
    
    private func formatDecimalString(value: String) -> String {
        guard let decimal = Decimal(string: value) else {
            return value
        }
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16
        formatter.numberStyle = .decimal
        return formatter.string(for: decimal) ?? value
    }
    
    private func calculatePercentage(actions: [String]) -> [String] {
        
        var updatedActions = actions
        
        if actions.count == 1, let number = Decimal(string: actions.first!) {
            
            let result = number / 100
            return [result.description]
        }

        if actions.count >= 3 {
                let lastIndex = actions.count - 1
                let lastAction = actions[lastIndex]
                
                
                if let lastNumber = Decimal(string: lastAction),
                   (actions[lastIndex - 1] == CalculatorButtonType.PLUS.symbol || actions[lastIndex - 1] == CalculatorButtonType.MINUS.symbol) {
                    
                    let previousNumber = Decimal(string: actions[lastIndex - 2]) ?? Decimal(0)
                    
                    let newValue = previousNumber * (lastNumber / 100)
                    updatedActions[lastIndex] = newValue.description
                }
                
                
                else if let lastNumber = Decimal(string: lastAction),
                        (actions[lastIndex - 1] == CalculatorButtonType.MULTIPLY.symbol || actions[lastIndex - 1] == CalculatorButtonType.DIVIDE.symbol) {
                    let newValue = lastNumber / 100
                    updatedActions[lastIndex] = newValue.description
                }
            }

        return updatedActions
    }
    
    private func toggleSign(actions: [String]) -> [String]{
        var updatedActions = actions
        
        if actions.count == 1, let number = Decimal(string: actions.first!) {
            
            let toggledNumber = number * -1
            updatedActions = [toggledNumber.description]
        } else if actions.count >= 3 {
            let lastIndex = actions.count - 1
            let lastAction = actions[lastIndex]
            
            if let lastNumber = Decimal(string: lastAction) {
                let toggledNumber = lastNumber * -1
                updatedActions[lastIndex] = toggledNumber.description
            }
        }
        
        return updatedActions
    }
}
