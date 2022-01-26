struct CodeConfirmPresenter: Presenter {
    weak var view: CodeConfirmViewController?

    func check(code: String) {
        //

        view?.output?.onCodeConfirm()
    }
}
