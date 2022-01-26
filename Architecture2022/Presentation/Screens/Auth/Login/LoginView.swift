import SwiftUI
import TISwiftUtils

struct LoginView: View {

    struct Output {
        let onLogin: ParameterClosure<LoginCredentials>
    }

    let presenter: LoginPresenter
    let output: Output

    @State var loginCredentials: LoginCredentials

    init(presenter: LoginPresenter, output: Output) {
        self.presenter = presenter
        self.output = output

        let login = presenter.authService.currentProfile?.login ?? .init()

        loginCredentials = LoginCredentials(login: login, password: .init())
    }

    var body: some View {
        VStack {
            Text("Login screen")
            TextField("Login", text: $loginCredentials.login).padding()
            TextField("Password", text: $loginCredentials.password).padding()
            Button("Login now") {
                output.onLogin(loginCredentials)
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(presenter: .init(authService: PreviewDependencies().authService),
                  output: .init(onLogin: { _ in
            //
        }))
    }
}
