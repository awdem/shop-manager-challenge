require 'order_repository'

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  describe '#all' do
    it 'returns all records on order table' do
      repo = OrderRepository.new

      orders = repo.all
      
      expect(orders.length).to eq 4
      
      expect(orders[0].id).to eq 1
      expect(orders[0].customer_name).to eq 'Jeff'
      expect(orders[0].order_date).to eq '2023-10-16'
      
      expect(orders[-1].id).to eq 4
      expect(orders[-1].customer_name).to eq 'George'
      expect(orders[-1].order_date).to eq '2024-01-16'      
    end
  end
end