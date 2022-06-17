import SwiftUI
import TISwiftUtils
import SwiftUIX

protocol PhoneLoginModule {
    var onGetCodeTapped: ParameterClosure<SMSSendRequestBody> { get set }
}

struct PhoneLoginView: View {
    @ObservedObject var presenter: PhoneLoginPresenter

    var body: some View {
        VStack {
            Text("Login screen")
            CocoaTextField("Phone", text: $presenter.dataModel.phone)
                .focused(presenter.isPhoneFieldFocusedBinding)
                .padding()
            Button(action: {
                presenter.didTapLogin()
            }) {
                Text("Get code")
                if presenter.isExecutingRequest {
                    ActivityIndicator()
                        .animated(presenter.isExecutingRequest)
                        .style(.regular)
                }
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneLoginPresenter
            .assembleForPreview()
            .createView()
    }
}
