import UIKit

class DetailMovieQuizViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    private var detailMovieQuizView: DetailMovieQuizView?
    private var viewModel: DetailMovieQuizViewModel?
    
    init(viewModel: DetailMovieQuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        detailMovieQuizView = DetailMovieQuizView()
        detailMovieQuizView?.delegate = self
        view = detailMovieQuizView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailMovieQuizView?.scoreLabel.text = viewModel?.getTextScore
    }
}

extension DetailMovieQuizViewController: DetailMovieQuizViewDelegate {
    func playAgainButtonDidTapped() {
        coordinator?.eventOcurred(with: .rootVC)
    }
}
