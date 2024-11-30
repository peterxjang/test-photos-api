require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    post "/users.json", params: { name: "test", email: "test@example.com", password: "password" }
    post "/sessions.json", params: { email: "test@example.com", password: "password" }
    get "/photos.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Photo.count, data.length
  end

  test "create" do
    assert_difference "Photo.count", 1 do
      post "/photos.json", params: { name: "lake", width: 800, height: 600 }
      assert_response 200
    end
  end

  test "show" do
    get "/photos/#{Photo.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "name", "width", "height", "created_at", "updated_at"], data.keys
  end

  test "update" do
    photo = Photo.first
    patch "/photos/#{photo.id}.json", params: { name: "Updated name" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated name", data["name"]
  end

  test "destroy" do
    assert_difference "Photo.count", -1 do
      delete "/photos/#{Photo.first.id}.json"
      assert_response 200
    end
  end
end
