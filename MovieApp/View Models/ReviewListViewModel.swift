
import Foundation
import CoreData

class ReviewListViewModel: ObservableObject {
    
   @Published var reviews = [ReviewViewModel]()
    
    func getReviewsByMovie(vm: MovieViewModel) {
        DispatchQueue.main.async {
            self.reviews = Review.getReviewsByMovieId(movieId: vm.movieId).map(ReviewViewModel.init)
        }
    }
}

struct ReviewViewModel {
    
    let review: Review
    
    var reviewId: NSManagedObjectID {
        return review.objectID
    }
    
//    var title: String {
//        return review.title ?? ""
//    }
//    
//    var text: String {
//        return review.text ?? ""
//    }

//     var internalTitle: String {
//            didSet {
//                // 这里可以执行文本修改和还原操作
//                // 例如，可以在 didSet 中将修改后的文本保存到 CoreData 实体中
////                internalTitle = internalTitle.convertAESString
//                print("获取加密后的\(internalTitle)")
//            }
//        }

        var title: String {
            get {
                let  xxx = (review.title ?? "").decrypedAESString
//                print("获取解密后的\(xxx)")
                return xxx

            }
            set {
                review.title = newValue.convertAESString
            }
        }

//        var internalText: String {
//            didSet {
//                // 这里可以执行文本修改和还原操作
//                // 例如，可以在 didSet 中将修改后的文本保存到 CoreData 实体中
////                internalText = internalText.convertAESString
//            }
//        }

        var text: String {
            get {
                let xxx = (review.text ?? "").decrypedAESString
                print("获取解密后的review存储text:\(xxx)， review.text:\(review.text ?? "")")
                return xxx
            }
            set {
                print("获取加密后的review存储text：\(newValue.convertAESString)， 原文:\(newValue)")
                review.text = newValue.convertAESString

//                text = (review.text ?? "").convertAESString
            }
        }

    var publishedDate: Date? {
        return review.publishedAt
    }
    
}
