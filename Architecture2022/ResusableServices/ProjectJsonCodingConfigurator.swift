import TIFoundationUtils

final class ProjectJsonCodingConfigurator: JsonCodingConfigurator {
    @Weaver(.reference)
    private var dateFormattersReusePool: DateFormattersReusePool

    @Weaver(.reference)
    private var iso8601DateFormattersReusePool: ISO8601DateFormattersReusePool

    init(injecting resolver: ProjectJsonCodingConfiguratorDependencyResolver) {
        super.init(dateFormattersReusePool: resolver.dateFormattersReusePool,
                   iso8601DateFormattersReusePool: resolver.iso8601DateFormattersReusePool)
    }
}
