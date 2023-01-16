import SwiftUI

struct DetailsView: View {

    @ObservedObject var presenter: DetailsPresenter

    var body: some View {
        Text("Details view for user \(presenter.userName)")
    }
}
