import Foundation

final class DetailMovieQuizViewModel {
    private var score: Float
    
    init(score: Float) {
        self.score = score
    }
    
    var getTextScore: String {
        return String(format: "%.0f", score) + "%"
    }
}
