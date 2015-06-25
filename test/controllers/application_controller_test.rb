require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
    test "to_source" do
        sut = ApplicationController.new

        result = sut.to_source(Product.all, {count: 2})
        assert_equal Product.count, result[:total]
        assert_equal 2, result[:data].length
    end

    test "to_source sorting" do
        # Arrange
        sut = ApplicationController.new

        ps = {
            orderBy: 'title',
            desc: false,
            count: 2
        }

        # Act
        result = sut.to_source(Product.all, ps)

        # Assert
        assert_equal Product.count, result[:total]
        assert_equal 'Jacob', result[:data].first.title

        # Arrange
        ps[:desc] = true

        # Act
        result = sut.to_source(Product.all, ps)

        # Assert
        assert_equal Product.count, result[:total]
        assert_equal 'Soki', result[:data].first.title

        # Arrange
        ps[:count] = 2

        # Act
        result = sut.to_source(Product.all, ps)

        # Assert
        assert_equal 2, result[:count]
        assert_equal 4, result[:total]

        # Arrange
        ps[:count] = 3
        ps[:page] = 2

        # Act
        result = sut.to_source(Product.all, ps)

        # Assert
        assert_equal 1, result[:count]
        assert_equal 4, result[:total]
    end
end

