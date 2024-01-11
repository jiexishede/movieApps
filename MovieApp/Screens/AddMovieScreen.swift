
import SwiftUI

struct AddMovieScreen: View {
   
    let types = videoTypes

    @StateObject private var addMovieVM = AddMovieViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField(NSLocalizedString("Enter name", comment: "用于输入名字"), text: $addMovieVM.title)
            TextField(NSLocalizedString("Enter director", comment: "用于输入导演"), text: $addMovieVM.director)

            Section("Synopsis") {
                TextEditor(text: $addMovieVM.synopsis)
                    .frame(minHeight: 40)
                    .padding()
            }

            Section("Type") {
                          Picker("Select Type", selection: $addMovieVM.type) {
                              ForEach(types, id: \.self) {
                                  Text(NSLocalizedString($0, comment: ""))
                              }
                          }.pickerStyle(.navigationLink)
            }

            HStack {
                Text(NSLocalizedString("Rating", comment: "用于输入评分处理"))
                Spacer()
                RatingView(rating: $addMovieVM.rating)
            }
            DatePicker(NSLocalizedString("Release Date", comment: "发布日期"), selection: $addMovieVM.releaseDate)
            HStack {
                Spacer()
//                Button("Save") {
                Button(NSLocalizedString("Save", comment: "用于保存操作")) {
                    addMovieVM.save()
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
            
        }
        .navigationTitle(NSLocalizedString("Add Movie", comment: "添加电影"))
        .embedInNavigationView()
    }
}

struct AddMovieScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieScreen()
    }
}
