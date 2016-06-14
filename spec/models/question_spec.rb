require 'rails_helper'
 
describe Question do

  before :each do
    @question = create(:user_with_question)
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should belong_to(:user) }

end