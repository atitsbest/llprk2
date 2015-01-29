require 'test_helper'

class ProductTest < ActiveSupport::TestCase
    test "product attributes must not be empty" do
        sut = Product.new

        assert sut.invalid?
        assert sut.errors[:title].any?
        assert sut.errors[:description].any?
        assert sut.errors[:price].any?
    end

    test "product price must be positive" do
        sut = Product.new(title: 'Meine Tasche',
                          description: "blah")
        sut.price = -1
        assert sut.invalid?

        sut.price = 0
        assert sut.invalid?

        sut.price = 1
        assert sut.valid?
    end

    test "has categories" do
        sut = products(:soki)

        assert_equal 2, sut.categories.length
        assert_equal 'Tasche', sut.categories.last.name
        assert_equal 'Frontpage', sut.categories.first.name
    end
end
