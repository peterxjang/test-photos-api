Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "example.com", "localhost:5173", "test-photos-frontend.onrender.com"
    resource "*", headers: :any, credentials: true, methods: [:get, :post, :patch, :put, :delete]
  end
end
