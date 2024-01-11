
import SwiftUI

struct AddActorScreen: View {
    
    let movie: MovieViewModel
    @StateObject private var addActorVM = AddActorViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
            Form {
                VStack(alignment: .leading) {
                    Text("Add Actor".localWithCom("添加演员"))
                        .font(.largeTitle)
                    Text(movie.title)
                }.padding(.bottom, 50)
                TextField("Enter name".localWithCom("输入名字"), text: $addActorVM.name)
                HStack {
                    Spacer()
                    Button("Cancel".localWithCom("取消按钮的文字")) {
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button("Save".localWithCom("保存按钮的文字")) {
                        addActorVM.addActorToMovie(movieId: movie.movieId)
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
    }
}

struct AddActorScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddActorScreen(movie: MovieViewModel(movie: Movie(context: Movie.viewContext)))
    }
}
