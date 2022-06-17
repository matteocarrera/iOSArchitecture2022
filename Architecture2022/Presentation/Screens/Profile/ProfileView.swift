import SwiftUI
import SwiftUIX

struct ProfileView: View {
    @ObservedObject var presenter: ProfilePresenter

    var body: some View {
        if presenter.state.isLoading {
            ActivityIndicator()
                .animated(presenter.state.isLoading)
                .style(.regular)
        } else if case let .content(content) = presenter.state {
            Text("Hello, " + content.name)
        } else if case let .error(errorResponse) = presenter.state {
            Text(errorResponse.errorMessage)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePresenter
            .assembleForPreview()
            .createView()
    }
}
