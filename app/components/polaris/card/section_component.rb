class Polaris::Card::SectionComponent < Polaris::NewComponent
  renders_many :subsections, "Polaris::Card::SubsectionComponent"

  def initialize(
    title: "",
    subdued: false,
    flush: false,
    full_width: false,
    unstyled: false,
    actions: [],
    **system_arguments
  )
    @system_arguments = system_arguments
    @system_arguments[:tag] = :div
    @system_arguments[:classes] = class_names(
      @system_arguments[:classes],
      "Polaris-Card__Section--flush": flush,
      "Polaris-Card__Section--subdued": subdued,
      "Polaris-Card__Section--fullWidth": full_width,
      "Polaris-Card__Section": !unstyled,
    )

    @title = title
    @actions = actions.map { |a| a.merge(plain: true) }
  end

  class Polaris::Card::SubsectionComponent < Polaris::NewComponent
    def initialize(**system_arguments)
      @system_arguments = system_arguments
      @system_arguments[:tag] = :div
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "Polaris-Card__Subsection",
      )
    end

    def call
      render(Polaris::BaseComponent.new(**@system_arguments)) { content }
    end
  end
end
