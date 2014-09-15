module StandardTasks
  class AwesomeAuthorsTask < Task
    title "Awesome Authors Task"
    role "author"

    has_many :awesome_authors

    validate :validate_authors, if: :completed?

    def active_model_serializer
      TaskSerializer
    end

    def validate_authors
      valid_authors = true
      awesome_authors.each do |a|
        if a.invalid?
          self.errors.add(:awesome_authors, a.formatted_errors)
          valid_authors = false
        end
      end
      self.errors.add(:completed, "Please check the errors above.") unless valid_authors
      self.errors.empty?
    end
  end
end