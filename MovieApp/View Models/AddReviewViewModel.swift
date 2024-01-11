
import Foundation

class AddReviewViewModel: ObservableObject {
    
    var title: String = ""
    var text: String = ""
    
    func addReviewForMovie(vm: MovieViewModel) {
        
        let movie: Movie? = Movie.byId(id: vm.movieId)
        
        let review = Review(context: Movie.viewContext)
        review.title = title
        let convertAESString = text.convertAESString
        review.text = convertAESString
        review.movie = movie
        
        // save the review
        try? review.save()
    }
    
}
