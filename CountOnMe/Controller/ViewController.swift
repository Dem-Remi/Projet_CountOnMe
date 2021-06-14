import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated : Bool) {
        super.viewDidAppear(animated)
    }
    
    let calcul = Calcul()
    
    // MARK: - Outlets
    
    // Calculation view
    @IBOutlet weak var textView: UITextView!
    
    // Table of number buttons
    @IBOutlet var numberButtons: [UIButton]!
    
    
    // MARK: - Actions
    
    @IBAction func tappedPointButton(_ sender: UIButton) {
        do {
            try calcul.addAPoint()
            textView.text = calcul.textToDisplay
        } catch CalculError.cannotAddAPoint {
            cannotAddAPointError()
        } catch {
        }
    }
    
    // Tap on the AC button to remove the last character
    @IBAction func ACButton(_ sender: UIButton) {
        guard textView.text.first != nil else {
            nothingToRemoveError()
            return
        }
        guard !calcul.expressionHaveResult else {
            calcul.deleteAll()
            textView.text = calcul.textToDisplay
            return
        }
        calcul.deleteTheLast()
        textView.text = calcul.textToDisplay
    }
    
    // Long press on the AC button to remove all the characters
    @IBAction func longPressACButton(_ sender: UILongPressGestureRecognizer) {
        calcul.deleteAll()
        textView.text = calcul.textToDisplay
    }
    
    // Action to tap on number buttons
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calcul.addNumber(numberText)
        textView.text = calcul.textToDisplay
    }
    
    // Action to tap on "+" button
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        do {
            try calcul.addAdditionOperator()
            textView.text = calcul.textToDisplay
        } catch CalculError.cannotAddOperator {
            cannotAddOperatorError()
        } catch {
        }
    }

    
    // Action to tap on "-" button
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        do {
            try calcul.addSubstractionOperator()
            textView.text = calcul.textToDisplay
        } catch CalculError.cannotAddOperator {
            cannotAddOperatorError()
        } catch {
        }
    }

    
    // Action to tap on "x" button
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calcul.canAddOperator {
            do {
                try calcul.addMultiplicationOperator()
                textView.text = calcul.textToDisplay
            } catch CalculError.cannotAddOperator {
                cannotAddOperatorError()
            } catch {
            }
        }
    }

    
    // Action to tap on "÷" button
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if calcul.canAddOperator {
            do {
                try calcul.addDivisionOperator()
                textView.text = calcul.textToDisplay
            } catch CalculError.cannotAddOperator {
                cannotAddOperatorError()
            } catch {
            }
        }
    }

    
    // Action to tap on "=" button
    @IBAction func tappedEqualButton(_ sender: Any) {
        do {
            try calcul.calculate()
            textView.text = calcul.textToDisplay
        } catch CalculError.expressionNotCorrect {
            expressionNotCorrectError()
        } catch CalculError.expressionNotEnoughtLong {
            expressionNotEnoughtLongError()
        } catch CalculError.divideByZero {
            divisionByZeroError()
        } catch CalculError.unknownOperator {
            unknownOperatorError()
            
        //🟠 Function under construction 🟠
        } catch CalculError.startByAnOperator {
            startByAnOperatorError()

        } catch {
        }
    }
    
    // MARK: - Error messages
    
    private func alertUser(title : String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func divisionByZeroError() {
        alertUser(title: "Alerte", message: "Division par zéro impossible.")
    }
    
    func unknownOperatorError() {
        alertUser(title: "Alerte", message: "Opérateur inconnu.")
    }
    
    func cannotAddAPointError() {
        alertUser(title: "Alerte", message: "Impossible d'ajouter une virgule.")
    }
    
    func expressionNotEnoughtLongError() {
        alertUser(title: "Alerte", message: "Démarrez un nouveau calcul.")
    }
    
    func expressionNotCorrectError() {
        alertUser(title: "Alerte", message: "Entrez une expression correcte.")
    }
    
    func cannotAddOperatorError() {
        alertUser(title: "Alerte", message: "Un opérateur est déjà en place.")
    }
    
    func nothingToRemoveError() {
        alertUser(title: "Alerte", message: "Il n'y a pas d'élement à effacer.")
    }
    
    func startByAnOperatorError() {
        alertUser(title: "Alerte", message: "Démarrez le calcul par un chiffre.")
    }
}
