import SwiftUI

struct EditProfileView: View {
    @ObservedObject var presenter: EditProfilePresenter

    var body: some View {
        Text("Editing of profile for user \(presenter.userName)")
    }
}
