require "test_helper"

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get people_url, as: :json
    assert_response :success
  end

  test "should create person" do
    assert_difference("Person.count") do
      post people_url, params: { person: { birth_year: @person.birth_year, eye_color: @person.eye_color, gender: @person.gender, hair_color: @person.hair_color, height: @person.height, homeworld_id: @person.homeworld_id, mass: @person.mass, name: @person.name, skin_color: @person.skin_color } }, as: :json
    end

    assert_response :created
  end

  test "should show person" do
    get person_url(@person), as: :json
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { birth_year: @person.birth_year, eye_color: @person.eye_color, gender: @person.gender, hair_color: @person.hair_color, height: @person.height, homeworld_id: @person.homeworld_id, mass: @person.mass, name: @person.name, skin_color: @person.skin_color } }, as: :json
    assert_response :success
  end

  test "should destroy person" do
    assert_difference("Person.count", -1) do
      delete person_url(@person), as: :json
    end

    assert_response :no_content
  end
end
