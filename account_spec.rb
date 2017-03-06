require "rspec"

require_relative "account"

describe Account do
let(:acct_number)      {"4444111144"}
let (:amount) {rand(1..999)}
# let(:starting_balance) {0}
# let(:transactions)     {[starting_balance]}
let(:account)             {Account.new(acct_number)}

  describe "#initialize" do
    context "with valid input" do
      it "creates a new bank account" do
      expect(Account.new("5555111155")).to be_an_instance_of(Account)
    end
  end
    context "with invalid input" do
      it "throws an argument error for less than one input" do
      expect {Account.new}.to raise_error(ArgumentError)
    end
  end
  end

  describe "#transactions" do
    it "is an array with at least one value in it" do
    expect(account.transactions).to be_a_kind_of(Array)
    expect(account.transactions).not_to be_empty
  end
    it "is an array that only includes integers" do
    expect(account.transactions).to all(be_an(Integer))
  end
end

  describe "#balance" do
    it "is one integer" do
      expect(account.balance).to be_a_kind_of(Integer)
    end

  end

  describe "#acct_number" do
    it "raises an error if the account number is not equal to ten digits" do
      expect {Account.new("111abc")}.to raise_error(InvalidAccountNumberError)
      end
    it "is a valid, hidden account number" do
    expect(account.acct_number).to match(/^*{6}\d{4}$/)
      end
    end

  describe "deposit!" do
    it "requires an argument" do
      expect{account.deposit!}.to raise_error(ArgumentError)
    end
    it "raises an error if amount is negative" do
      expect{account.deposit!(-1)}.to raise_error(NegativeDepositError)
      expect{account.deposit!(-99)}.to raise_error(NegativeDepositError)
    end
     it "increases the balance after a new deposit"do
       expect{account.deposit!(amount)}.to change{account.balance}.by(+ amount)
     end
  end

  describe "#withdraw!" do
    it "requires an argument" do
      expect{account.withdraw!}.to raise_error(ArgumentError)
    end
     it "decreases the balance after a new withdraw"do
       account.deposit!(1000)
       expect{account.withdraw!(amount)}.to change{account.balance}.by(- amount)
     end
  end
end
