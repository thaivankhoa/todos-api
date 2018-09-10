require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Validation' do  
    it { should validate_presence_of(:name) }
  end 
  
  describe 'Association' do  
    it { should belong_to(:todo) } 
  end 
end
