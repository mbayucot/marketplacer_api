require 'rails_helper'
require 'rake'

RSpec.describe 'db:load_products' do
  before :all do
    Rake.application.rake_require 'tasks/load_products'
    Rake::Task.define_task(:environment)
  end

  let(:task) { Rake::Task['db:load_products'] }

  before do
    file_path = Rails.root.join('db', 'products.json')
    products_json = [
      { 'uuid' => '1', 'name' => 'Product 1', 'price' => 10.0 },
      { 'uuid' => '2', 'name' => 'Product 2', 'price' => 20.0 }
    ].to_json

    allow(File).to receive(:read).with(file_path).and_return(products_json)
  end

  it 'loads products from a file' do
    expect { task.invoke }.to change { Product.count }.by(2)

    product1 = Product.find_by(uuid: '1')
    expect(product1).not_to be_nil
    expect(product1.name).to eq('Product 1')
    expect(product1.price).to eq(10.0)

    product2 = Product.find_by(uuid: '2')
    expect(product2).not_to be_nil
    expect(product2.name).to eq('Product 2')
    expect(product2.price).to eq(20.0)
  end
end
