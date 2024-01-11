import Foundation

class UpdateMovieViewModel: ObservableObject {

    var movie : Movie = Movie()
    var title: String = ""
    var director: String = ""
    @Published var type: String = ""
    var synopsis: String = "" // 剧情简介
//    var rating: Int? = nil
    @Published var rating: Int? = nil
    var releaseDate: Date = Date()

    init(movie: Movie) {
        self.movie = movie
        title = movie.title ?? ""
        director = movie.director ?? ""
        rating = Int(movie.rating)
        releaseDate = movie.releaseDate ?? Date()
        synopsis = movie.synopsis ?? ""
        type = movie.type ?? ""
    }

    func save() {

        movie.title = title
        movie.director = director
        movie.synopsis = synopsis
        movie.type = type
        movie.rating = Double(rating ?? 0)
        movie.releaseDate = releaseDate

        try? movie.save()
    }

}
