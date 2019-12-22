import UIKit

class NextController: UIViewController {
    @IBOutlet var label: UILabel!

    var onClose: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func unwindToTop(segue _: UIStoryboardSegue) {
        dismiss(animated: true, completion: { [weak self] () in
            self?.onClose?()
        })
    }
}
