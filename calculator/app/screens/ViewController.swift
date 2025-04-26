

import UIKit


class ViewController: UIViewController,CalculatorButtonDelegate{

    var mainStack: UIStackView = UIStackView()
    var resultLabel: UILabel = UILabel()

    var actions : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildMainStack()
        buildResultLabel()
        buildFirstLineStack()
        buildSecondLineStack()
        buildThirdLineStack()
        buildFourthLineStack()
        buildFifthLineStack()
    }
    
    private func buildMainStack(){
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fillProportionally
        mainStack.backgroundColor = .white
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.spacing = 14
        
        view.backgroundColor = .white
        view.addSubview(mainStack)
        
        var constraints = [NSLayoutConstraint]()

        constraints.append(mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16))
        constraints.append(mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16))
        constraints.append(mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -30))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func buildResultLabel() {
       
        resultLabel.textColor = .black
        resultLabel.font = .systemFont(ofSize: 90)
        resultLabel.textAlignment = .right
        resultLabel.text = CalculatorButtonType.ZERO.symbol
        resultLabel.numberOfLines = 1

        mainStack.addArrangedSubview(resultLabel)
    }
    
    private func buildFirstLineStack() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 14
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        let acButton = CalculatorButton()
        acButton.configure(font: .systemFont(ofSize: 34),calculatorButtonType: .CLEAR);
        acButton.delegate = self
        stack.addArrangedSubview(acButton)
        
        let unknownButton = CalculatorButton()
        unknownButton.configure(font: .boldSystemFont(ofSize: 18),calculatorButtonType: .TOGGLE);
        unknownButton.delegate = self
        stack.addArrangedSubview(unknownButton)
        
        let percentButton = CalculatorButton()
        percentButton.configure(font: .boldSystemFont(ofSize: 32), calculatorButtonType: .PERCENTAGE);
        percentButton.delegate = self
        stack.addArrangedSubview(percentButton)
        
        let divideButton = CalculatorButton()
        divideButton.configure(font: .boldSystemFont(ofSize: 46),calculatorButtonType: .DIVIDE);
        divideButton.delegate = self
        stack.addArrangedSubview(divideButton)
        
        mainStack.addArrangedSubview(stack)
    }
    
    private func buildSecondLineStack(){
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 14
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        let sevenButton = CalculatorButton()
        sevenButton.configure(calculatorButtonType: .SEVEN);
        sevenButton.delegate = self
        stack.addArrangedSubview(sevenButton)
        
        let eightButton = CalculatorButton()
        eightButton.configure(calculatorButtonType: .EIGHT);
        eightButton.delegate = self
        stack.addArrangedSubview(eightButton)
        
        let nineButton = CalculatorButton()
        nineButton.configure(calculatorButtonType: .NINE);
        nineButton.delegate = self
        stack.addArrangedSubview(nineButton)
        
        let multiplyButton = CalculatorButton()
        multiplyButton.configure(font: .boldSystemFont(ofSize: 42),calculatorButtonType: .MULTIPLY);
        multiplyButton.delegate = self
        stack.addArrangedSubview(multiplyButton)

        mainStack.addArrangedSubview(stack)
    }
    
    private func buildThirdLineStack(){
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 14
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        let fourButton = CalculatorButton()
        fourButton.configure(calculatorButtonType: .FOUR);
        fourButton.delegate = self
        stack.addArrangedSubview(fourButton)
        
        let fiveButton = CalculatorButton()
        fiveButton.configure(calculatorButtonType: .FIVE);
        fiveButton.delegate = self
        stack.addArrangedSubview(fiveButton)
        
        let sixButton = CalculatorButton()
        sixButton.configure(calculatorButtonType: .SIX);
        sixButton.delegate = self
        stack.addArrangedSubview(sixButton)
        
        let minusButton = CalculatorButton()
        minusButton.configure(font: .boldSystemFont(ofSize: 40),calculatorButtonType: .MINUS);
        minusButton.delegate = self
        stack.addArrangedSubview(minusButton)

        mainStack.addArrangedSubview(stack)
    }
    
    private func buildFourthLineStack(){
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 14
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        let oneButton = CalculatorButton()
        oneButton.configure(calculatorButtonType: .ONE);
        oneButton.delegate = self
        stack.addArrangedSubview(oneButton)
        
        let twoButton = CalculatorButton()
        twoButton.configure(calculatorButtonType: .TWO);
        twoButton.delegate = self
        stack.addArrangedSubview(twoButton)
        
        let threeButton = CalculatorButton()
        threeButton.configure(calculatorButtonType: .THREE);
        threeButton.delegate = self
        stack.addArrangedSubview(threeButton)
        
        let plusButton = CalculatorButton()
        plusButton.configure(font: .boldSystemFont(ofSize: 40),calculatorButtonType: .PLUS);
        plusButton.delegate = self
        stack.addArrangedSubview(plusButton)
        
        mainStack.addArrangedSubview(stack)
    }
    
    private func buildFifthLineStack(){
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 14
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        
        let zeroButton = CalculatorButton()
        zeroButton.configure(calculatorButtonType: .ZERO,contentAlignment: .leading,titleEdgeInsets: UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 0));
        zeroButton.delegate = self
        stack.addArrangedSubview(zeroButton)
        
        let commaButton = CalculatorButton()
        commaButton.configure(calculatorButtonType: .COMMA);
        commaButton.delegate = self
        stack.addArrangedSubview(commaButton)
        
        let equalButton = CalculatorButton()
        equalButton.configure(font: .boldSystemFont(ofSize: 40),calculatorButtonType: .EQUAL);
        equalButton.delegate = self
        stack.addArrangedSubview(equalButton)
        
        mainStack.addArrangedSubview(stack)
        
        commaButton.widthAnchor.constraint(equalTo:stack.widthAnchor,multiplier: 0.25).isActive = true
        equalButton.widthAnchor.constraint(equalTo:stack.widthAnchor,multiplier: 0.25).isActive = true
    }
}
