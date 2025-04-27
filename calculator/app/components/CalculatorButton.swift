import UIKit


protocol CalculatorButtonDelegate: AnyObject {
    func calculatorButtonTapped(calculatorButtonType: CalculatorButtonType)
}

class CalculatorButton : UIButton {

    weak var delegate: CalculatorButtonDelegate?
    var calculatorButtonType : CalculatorButtonType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        self.layer.cornerRadius = 32
        self.setTitleColor(.white, for: .normal)
        self.addTarget(self, action: #selector(handleTap),for: .touchUpInside)
    }
    
    func configure(
        font: UIFont = .systemFont(ofSize: 40),
        calculatorButtonType: CalculatorButtonType,
        contentAlignment : UIControl.ContentHorizontalAlignment = .center,
        titleEdgeInsets: UIEdgeInsets = .zero
    ){
        self.setTitle(calculatorButtonType.rawValue, for: .normal)
        self.backgroundColor = calculatorButtonType.buttonColor
        self.titleLabel?.font = font
        self.contentHorizontalAlignment = contentAlignment
        self.titleEdgeInsets = titleEdgeInsets
        self.calculatorButtonType = calculatorButtonType
        self.addTarget(self , action: #selector(handleTap), for: .touchUpInside)
        
        if(calculatorButtonType != .ZERO){
            NSLayoutConstraint.activate(
                [
                    .init(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
                ]
            )
        }
    }
    
    @objc private func handleTap() {
        delegate?.calculatorButtonTapped(calculatorButtonType: self.calculatorButtonType!)
    }
}


