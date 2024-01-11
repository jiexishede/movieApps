
import Foundation
import CoreData

class ActorListViewModel: ObservableObject {
    
    @Published var actors = [ActorViewModel]()
    
    func getActorsByMovie(vm: MovieViewModel) {
        DispatchQueue.main.async {
            self.actors = Actor.getActorsByMovieId(movieId: vm.movieId).map(ActorViewModel.init)
        }
    }
}

struct ActorViewModel {
    
    let actor: Actor
    
    var actorId: NSManagedObjectID {
        return actor.objectID
    }
    
    var name: String {
        let xxx = (actor.name ?? "").decrypedAESString
        print("获取解密后的actor.name存储text:\(xxx)， actor.name:\(actor.name ?? "")")
        return xxx
//        return actor.name ?? ""
    }
    
    var movies: [MovieViewModel] {
        return Movie.byActorName(name: name).map(MovieViewModel.init)
    }
}
