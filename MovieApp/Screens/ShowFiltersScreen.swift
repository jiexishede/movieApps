
import SwiftUI

struct ShowFiltersScreen: View {
    
    @State private var releaseDate: String = ""
    @State private var startDate: String = ""
    @State private var endDate: String = ""
    @State private var minimumRating: String = ""
    @State private var movieTitle: String = ""
    @State private var actorName: String = ""
    @State private var minimumReviewCount: String = "1"
    
    @Binding var movies: [MovieViewModel]
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var filtersVM = FiltersViewModel()
    
    var body: some View {
        Form {
            
            Section(header: Text("Search by release date".localWithCom("通过发布日期来搜索"))) {
                TextField("Enter release date".localWithCom("输入发布日期"), text: $releaseDate)
                HStack {
                    Spacer()
                    Button("Search".localWithCom("搜索按钮的显示文字")) {

                        if let releaseDate = releaseDate.asDate() {
                           movies =  filtersVM.filterMoviesByReleaseDate(releaseDate: releaseDate)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range".localWithCom("SectionHeader的文字显示 通过日期范围来搜搜"))) {
                TextField(NSLocalizedString("Enter start date", comment: "输入开始日期"), text: $startDate)
                TextField(NSLocalizedString("Enter end date", comment: "输入结束日期"), text: $endDate)
                HStack {
                    Spacer()
                    Button("Search".localWithCom("搜索按钮显示文体")) {

                        guard let lowerBound = startDate.asDate(),
                              let upperBound = endDate.asDate() else {
                            return
                        }
                        
                        movies =  filtersVM.filterMoviesByDateRange(lowerBoundDate: lowerBound, upperBoundDate: upperBound)
                        
                        presentationMode.wrappedValue.dismiss()
                       
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range or rating".localWithCom("通过时间或者评论来搜索"))) {
                TextField(NSLocalizedString("Enter start date", comment: "输入开始日期"), text: $startDate)
                TextField(NSLocalizedString("Enter end date", comment: "输入结束日期"), text: $endDate)
                TextField("Enter minimum rating".localWithCom("输入最小的评论数"), text: $minimumRating)
                HStack {
                    Spacer()
                    Button("Search".localWithCom("搜索按钮有的显示文字")) {

                        let lowerBound = startDate.asDate()
                        let upperBound = endDate.asDate()
                        let minRating = Int(minimumRating)
                        
                        movies =  filtersVM.filterMoviesByDateRangeOrMinimumRating(lowerBoundDate: lowerBound, upperBoundDate: upperBound, minimumRating: minRating)
                        
                        presentationMode.wrappedValue.dismiss()
                        
                       
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by movie title begins with")) {
                TextField("Enter movie title", text: $movieTitle)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        movies = filtersVM.filterMoviesByTitle(title: movieTitle)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by actor name")) {
                TextField("Enter actor name", text: $actorName)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        movies = filtersVM.filterMoviesByActorName(name: actorName)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search movies by minimum review count")) {
                TextField("Enter minimum review count", text: $minimumReviewCount)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        if !minimumReviewCount.isEmpty {
                            movies =  filtersVM.filterMoviesByMinimumReviewCount(minimumReviewCount: Int(minimumReviewCount) ?? 0)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
        }
        .navigationTitle("Filters".localWithCom("过滤筛选"))
        .embedInNavigationView()
    }
}

struct ShowFiltersScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShowFiltersScreen(movies: .constant([MovieViewModel(movie: Movie())]))
    }
}
