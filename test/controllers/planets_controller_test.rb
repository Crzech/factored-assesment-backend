require "test_helper"

class PlanetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @planet = planets(:one)
  end

  test "should get index" do
    get planets_url, as: :json
    assert_response :success
  end

  test "should create planet" do
    assert_difference("Planet.count") do
      post planets_url, params: { planet: { climate: @planet.climate, diameter: @planet.diameter, gravity: @planet.gravity, id: @planet.id, name: @planet.name, orbital_period: @planet.orbital_period, population: @planet.population, rotation_period: @planet.rotation_period, surface_water: @planet.surface_water, terrain: @planet.terrain } }, as: :json
    end

    assert_response :created
  end

  test "should show planet" do
    get planet_url(@planet), as: :json
    assert_response :success
  end

  test "should update planet" do
    patch planet_url(@planet), params: { planet: { climate: @planet.climate, diameter: @planet.diameter, gravity: @planet.gravity, id: @planet.id, name: @planet.name, orbital_period: @planet.orbital_period, population: @planet.population, rotation_period: @planet.rotation_period, surface_water: @planet.surface_water, terrain: @planet.terrain } }, as: :json
    assert_response :success
  end

  test "should destroy planet" do
    assert_difference("Planet.count", -1) do
      delete planet_url(@planet), as: :json
    end

    assert_response :no_content
  end
end
