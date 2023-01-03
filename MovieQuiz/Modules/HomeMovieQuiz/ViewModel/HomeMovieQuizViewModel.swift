import Foundation

typealias Round = (quiz: Quiz, options: [QuizOption])

final class HomeMovieQuizViewModel {
    private var quizes = [Quiz]()
    private var quizOptions = [QuizOption]()
    private var score: Int = 0

    private var round: Round?
    
    var getRound: Round? {
        return round
    }
    
    var getScore: Float {
        let percentage = Float(score) / Float(quizes.count) * 100
        return percentage
    }
    
    private let service: NetworkServiceDataProviderProtocol?
    
    init(service: NetworkServiceDataProviderProtocol?) {
        self.service = service
    }
    
    func fetchQuizes() {
        service?.fetchJSON(of: [Quiz].self, forResource: "quizes", completion: { [weak self] (quizesResult) in
            switch quizesResult {
            case .success(let result):
                self?.quizes = result
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchQuizOptions() {
        service?.fetchJSON(of: [QuizOption].self, forResource: "options", completion: { [weak self] (quizOptionResult) in
            switch quizOptionResult {
            case .success(let result):
                self?.quizOptions = result
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func clearScore() {
        score = 0
    }
    
    func generateRandomQuiz() -> Round {
        let quizIndex = Int(arc4random_uniform(UInt32(quizes.count)))
        let quiz = quizes[quizIndex]
        
        var indexes: Set<Int> = [quizIndex]
        
        while indexes.count < 4 {
            let index = Int(arc4random_uniform(UInt32(quizes.count)))
            indexes.insert(index)
        }
        
        let options = indexes.map({ quizOptions[$0] })
        round = (quiz, options)
        return round!
    }
    
    func checkAnswer(_ answer: String) {
        guard let round = round else { return }
        
        if answer == round.quiz.name {
            score += 1
            print("Acertou")
        }
    }
}
