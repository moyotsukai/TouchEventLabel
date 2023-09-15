//
//  ViewController.swift
//  TouchEventLabel
//
//  Created by Owner on 2022/11/29.
//

import UIKit

class ViewController: UIViewController {
    
    var labelArray: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        onScreenTouch(at: location)
    }
    
    func onScreenTouch(at location: CGPoint) {
        let tapIndicatorView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 6))
        tapIndicatorView.layer.cornerRadius = 3
        tapIndicatorView.center = location
        tapIndicatorView.backgroundColor = .orange
        self.view.addSubview(tapIndicatorView)
        
        presentAlertWithTextField { text, isLabelAdded in
            if isLabelAdded {
                self.addLabel(at: location, text: text)
            }
            tapIndicatorView.removeFromSuperview()
        }
    }
    
    func presentAlertWithTextField(completion: @escaping (String, Bool) -> Void) {
        let alert = UIAlertController(title: "テキスト", message: nil, preferredStyle: .alert)
        var textField = UITextField()
        alert.addTextField { addedTextField in
            addedTextField.returnKeyType = .done
            textField = addedTextField
        }
        alert.addAction(UIAlertAction(title: "完了", style: .default) { _ in
            completion(textField.text ?? "", true)
        })
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel) { _ in
            completion(textField.text ?? "", false)
        })
        present(alert, animated: true)
    }
    
    func addLabel(at location: CGPoint, text: String) {
        //Size
        let label = UILabel()
        label.text = text
        let size = label.sizeThatFits(CGSize(width: 1000, height: 1000))
        let padding = CGSize(width: 10, height: 6)
        label.frame.size = CGSize(width: size.width + padding.width * 2, height: size.height + padding.height * 2)
        label.center = location
        
        //Style
        label.backgroundColor = .orange
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        
        //Add
        labelArray.append(label)
        self.view.addSubview(label)
    }
    
    @IBAction func undo() {
        if labelArray.isEmpty { return }
        labelArray.removeLast().removeFromSuperview()
    }
    
    private var myInputAccessoryView: InputAccessoryView = {
        let view = InputAccessoryView()
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
        return view
    }()
    override var inputAccessoryView: UIView? { myInputAccessoryView }
    override var canBecomeFirstResponder: Bool { true }
    
}

