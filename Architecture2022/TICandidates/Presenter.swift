protocol Presenter {
    associatedtype View

    var view: View? { get set }
}
