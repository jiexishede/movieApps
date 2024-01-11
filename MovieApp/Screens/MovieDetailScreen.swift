
import SwiftUI

enum MovieDetailsRoutes: Identifiable, CaseIterable {
    
    var id: UUID {
        return UUID()
    }
    
    case reviews
    case actors
}

extension MovieDetailsRoutes {
    
    var displayText: String {
        switch self {
            case .reviews:
                return "Reviews"
            case .actors:
                return "Actors"
        }
    }
}

struct MovieDetailScreen: View {
 
    let types = videoTypes

    @ObservedObject var upDateMovieVM = UpdateMovieViewModel(movie: Movie())
    @ObservedObject var movieVM = MovieListViewModel()
    let movie: MovieViewModel
    var body: some View {
        VStack {

            Form() {
                Section("movie name") {
                    TextField("Enter name".localWithCom("文字输入框中的输入名字的提示"), text: $upDateMovieVM.title).padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                }
                Section("movie director") {
                    TextField("Enter director".localWithCom("文字输入框中的导员输入提示"), text: $upDateMovieVM.director)
                }
                Section("Synopsis") {
                    TextEditor(text: $upDateMovieVM.synopsis)
                        .frame(minHeight: 40)
                        .padding()
                }
                Section("Type") {
                              Picker("Select Type", selection: $upDateMovieVM.type) {

                                  
                                  ForEach(types, id: \.self) {
                                      Text(NSLocalizedString($0, comment: ""))
//                                      Text($0)
                                  }
                              }.pickerStyle(.navigationLink)
                }
                HStack {
                    Text("Rating".localWithCom("显示纯文本评分"))
                    Spacer()
                    RatingView(rating: $upDateMovieVM.rating)
                }
                DatePicker("Release Date".localWithCom("发布日期"), selection: $upDateMovieVM.releaseDate)

                HStack {
                    Spacer()
                    Button(NSLocalizedString("Save update", comment: "电影详情的界面")) {
                        upDateMovieVM.save()
                    }
                    Spacer()
                }.padding(10)

                Section {
                    NavigationLink(
                        destination: ReviewListScreen(movie: movie),
                        label: {
                            Text("Reviews".localWithCom("评论数"))
                        })

                    NavigationLink(
                        destination: ActorListScreen(movie: movie),
                        label: {
                            Text("Actors".localWithCom("演员集合"))
                        })
                }
            }
                .background(.white)
//
//            List {
//
//                
//            }.listStyle(PlainListStyle())
        }.navigationTitle(movie.title)
            .onAppear {

            }
            .onDisappear {
                movieVM.updateHomeUI()
            }
    }
}

struct MovieDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        MovieDetailScreen(movie: MovieViewModel(movie: Movie(context: CoreDataManager.shared.viewContext)))
            .embedInNavigationView()
    }
}
