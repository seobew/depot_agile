require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    puts "run rake test:units this line is printed"
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(
      title: "My book title",
      description: "yyy",
      image_url: "zzz.jpg"
    )

    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(
      title: "My book title",
      description: "yyy",
      price: 1,
      image_url: image_url
    )
  end

  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |image_name|
      assert new_product(image_name).valid?, "#{image_name} shouldn’t be invalid"
    end

    bad.each do |image_name|
      assert new_product(image_name).invalid?, "#{image_name} shouldn’t be valid"
    end
  end

end
