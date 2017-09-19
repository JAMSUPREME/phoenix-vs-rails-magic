class ApiCaller
  class << self
    def get(user, options)
      return authorized_get(options) if user.authorized?

      return unauthorized_get(options)
    end

    private

    def unauthorized_get(options)
      puts "No Auth GET with options: #{options}"
    end

    def authorized_get(options)
      puts "Authorized GET with options: #{options}"
    end
  end
end