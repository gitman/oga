require 'spec_helper'

describe Oga::XPath::Compiler do
  describe 'starts-with() function' do
    before do
      @document = parse('<root><a>foo</a><b>foobar</b></root>')

      @a1 = @document.children[0].children[0]
    end

    describe 'at the top-level' do
      it 'returns true if the 1st string starts with the 2nd string' do
        evaluate_xpath(@document, 'starts-with("foobar", "foo")').should == true
      end

      it "returns false if the 1st string doesn't start with the 2nd string" do
        evaluate_xpath(@document, 'starts-with("foobar", "baz")').should == false
      end

      it 'returns true if the 1st node set starts with the 2nd string' do
        evaluate_xpath(@document, 'starts-with(root/a, "foo")').should == true
      end

      it 'returns true if the 1st node set starts with the 2nd node set' do
        evaluate_xpath(@document, 'starts-with(root/b, root/a)').should == true
      end

      it "returns false if the 1st node set doesn't start with the 2nd string" do
        evaluate_xpath(@document, 'starts-with(root/a, "baz")').should == false
      end

      it 'returns true if the 1st string starts with the 2nd node set' do
        evaluate_xpath(@document, 'starts-with("foobar", root/a)').should == true
      end

      it 'returns true when using two empty strings' do
        evaluate_xpath(@document, 'starts-with("", "")').should == true
      end
    end

    describe 'in a predicate' do
      it 'returns a NodeSet containing all matching nodes' do
        evaluate_xpath(@document, 'root/a[starts-with("foo", "foo")]')
          .should == node_set(@a1)
      end
    end
  end
end
