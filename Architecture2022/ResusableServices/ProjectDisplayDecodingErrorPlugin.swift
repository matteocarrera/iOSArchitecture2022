import SwiftMessages
import Dispatch
import class UIKit.UIPasteboard
import TIMoyaNetworking

final class ProjectDisplayDecodingErrorPlugin: DisplayDecodingErrorPlugin {
    override func display(summary: DecodingErrorSummary) {
        DispatchQueue.main.async {
            let view = MessageView.viewFromNib(layout: .messageView)
            view.configureTheme(.error)
            view.configureContent(title: "Decoding error",
                                  body: "\n" + summary.description,
                                  iconImage: nil,
                                  iconText: nil,
                                  buttonImage: nil,
                                  buttonTitle: "Copy") { _ in
                UIPasteboard.general.string = summary.description
            }

            var config = SwiftMessages.Config()
            config.duration = .seconds(seconds: 15)

            SwiftMessages.sharedInstance.show(config: config, view: view)
        }
    }
}
