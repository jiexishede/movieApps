
import SwiftUI

@main
struct MovieAppApp: App {
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some Scene {
        WindowGroup {
            MovieListScreen()
        }
    }
}
