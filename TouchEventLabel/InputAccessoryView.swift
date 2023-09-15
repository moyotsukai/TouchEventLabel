import UIKit

final class InputAccessoryView: UIView {

    @IBOutlet var textView: UITextView!
    @IBOutlet var sendButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
//        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    func setupViews() {
//        textView.layer.cornerRadius = 15
//        sendButton.layer.cornerRadius = 15
//    }

}

// MARK: - setup nib
private extension InputAccessoryView {
    func loadNib() {
        let nib = UINib(nibName: String(describing: InputAccessoryView.self), bundle: nil)
        guard let view = nib.instantiate(withOwner: self,
                                         options: nil).first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
}

