# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_id         :string(255)      not null
#  first_name      :string(255)      not null
#  last_name       :string(255)
#  employee_number :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.create(:user) }

  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:first_name) }
  it { is_expected.to respond_to(:last_name) }
  it { is_expected.to respond_to(:employee_number) }
  it { is_expected.to respond_to(:created_at) }
  it { is_expected.to respond_to(:updated_at) }

  context '.create' do
    let!(:params){
      {
        id: 1,
        user_id: 'jsmith',
        first_name: 'John',
        last_name: 'Smith',
        employee_number: 100
      }
    }

    it 'does not raise an error' do
      expect{ User.create(params) }.not_to raise_error
    end

    it 'is stored' do
      User.create(params)
      expect(User.where(id: params[:id]).first).to be
    end

    context 'is stored correctly' do
      before {
        User.create(params)
      }
      subject(:user){
        User.where(id: params[:id]).first
      }

      it 'id is correct' do
        expect(user.id).to eq(params[:id])
      end

      it 'user_id is correct' do
        expect(user.user_id.to_s).to eq(params[:user_id])
      end

      it 'employee_number is correct' do
        expect(user.employee_number).to eq(params[:employee_number])
      end

      it 'first_name is correct' do
        expect(user.first_name).to eq(params[:first_name])
      end

      it 'last_name is correct' do
        expect(user.last_name).to eq(params[:last_name])
      end
    end

    describe 'it will reject user with the same employee_number' do
      let!(:user){
        User.create({id: 2,
                     user_id: 'aliza',
                     first_name: 'Anna',
                     last_name: 'Liza',
                     employee_number: 100}
        )
      }

      it 'will not store a duplicate' do
        expect{
          User.create({id: 3, user_id: 'aliza', first_name: 'Anna', last_name: 'Liza', employee_number: 100})
        }.to raise_error ActiveRecord::RecordNotUnique
      end
    end
  end
end
