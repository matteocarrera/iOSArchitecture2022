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
            createProfileView(with: content.name)
        } else if case let .error(errorResponse) = presenter.state {
            Text(errorResponse.errorMessage)
        }
    }

    @ViewBuilder
    func createProfileView(with name: String) -> some View {
        VStack(spacing: 10) {
            Text("Hello, " + name)

            if #available(iOS 16, *) {
                createUrlText(URL.profileDetails)
                createUrlText(URL.editProfile)
            }
        }
    }

    @available(iOS 16, *)
    @ViewBuilder
    func createUrlText(_ url: URL) -> some View {
        Text(url, format: .url)
            .bold()
            .foregroundColor(.blue)
            .onTapGesture {
                _ = UIApplication.shared.delegate?.application?(.shared, open: url)
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
