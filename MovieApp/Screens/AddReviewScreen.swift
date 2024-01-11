
import SwiftUI

struct AddReviewScreen: View {
    
    @StateObject private var addReviewVM = AddReviewViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let movie: MovieViewModel
    
    var body: some View {
        Form {
            TextField("Enter title".localWithCom("用来输入标题"), text: $addReviewVM.title)
            TextEditor(text: $addReviewVM.text)
            
            HStack {
                Spacer()
                Button("Save".localWithCom("保存按钮标识")) {
                    addReviewVM.addReviewForMovie(vm: movie)
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
        }
        .navigationTitle(NSLocalizedString("Add Review", comment: "添加评论页面的导航标题"))
        .embedInNavigationView()
    }
}

struct AddReviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let movie = MovieViewModel(movie: Movie(context: CoreDataManager.shared.viewContext))
        AddReviewScreen(movie: movie)
    }
}
