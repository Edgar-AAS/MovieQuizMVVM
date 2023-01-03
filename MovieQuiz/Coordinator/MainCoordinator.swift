import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOcurred(with type: Event) {
        switch type {
        case .pushToDetailMovieVC(let score):
            let viewModel = DetailMovieQuizViewModel(score: score)
            var vc: UIViewController & Coordinating = DetailMovieQuizViewController(viewModel: viewModel)
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: false)
        case .rootVC:
            navigationController?.popToRootViewController(animated: false)
        }
    }
    
    func start() {
        let service: NetworkServiceDataProviderProtocol = NetworkService()
        let viewModel = HomeMovieQuizViewModel(service: service)
        
        var vc: UIViewController & Coordinating = HomeMovieQuizViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}
