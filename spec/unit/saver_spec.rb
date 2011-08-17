require 'spec_helper'

describe Saver do
  class SingleTest
    include MongoMapper::Document
    include Saver

    key :data, Integer

    save_attribute :data

    def to_s
      "Number #{self.data}"
    end

    def long_string
      "OMG LONG Number #{self.data}"
    end
  end

  class DoubleTest
    include MongoMapper::Document
    include Saver

    key :data, Integer
    belongs_to :single_test

    save_attributes :data, :single_test
  end

  class MethodTest
    include MongoMapper::Document
    include Saver

    belongs_to :single_test

    save_attribute :single_test, :method => :long_string
  end

  let(:single_test) { SingleTest.create(:data => 5) }
  let(:double_test) { DoubleTest.create(:data => 5, :single_test => single_test) }
  let(:method_test) { MethodTest.create(:single_test => single_test) }

  describe '#savers' do
    it "should accurately save array of savers" do
      single_test.class.savers.should == { :data => :to_s }
      double_test.class.savers.should == { :data => :to_s, :single_test => :to_s }
    end
  end

  describe '#save_attribute' do
    it "should work" do
      single_test.data_saver.should == '5'
    end

    it "should work with custom method" do
      method_test.single_test_saver.should == 'OMG LONG Number 5'
    end
  end

  describe '#save_attributes' do
    it "should work" do
      double_test.data_saver.should == '5'
      double_test.single_test_saver.should == 'Number 5'
    end
  end
end
