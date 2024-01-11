
import Foundation
import CoreData

class MovieListViewModel: ObservableObject {
    
    @Published var movies = [MovieViewModel]()
    
    func deleteMovie(movie: MovieViewModel) {
        let movie: Movie? = Movie.byId(id: movie.movieId)
        if let movie = movie {
            try? movie.delete()
        }
    }
    
    func getAllMovies() {
        DispatchQueue.main.async {
            self.movies = Movie.all().map(MovieViewModel.init)
        }
    }

}

extension MovieListViewModel {

    func updateHomeUI() {
//          objectWillChange.send()
    }

}

class MovieViewModel {

    var movie: Movie = Movie()

    init(movie: Movie) {
        self.movie = movie
    }

    var movieId: NSManagedObjectID {
        return movie.objectID
    }
    
    var title: String {
        return movie.title ?? ""
    }

    var type: String {
        return movie.type ?? ""
    }

    var synopsis: String {
        return movie.type ?? ""
    }

    var director: String {
        return movie.director ?? "Not available"
    }
    
    var releaseDate: String? {
        return movie.releaseDate?.asFormattedString()
    }
    
    var rating: Int? {
        return Int(movie.rating)
    }

}
