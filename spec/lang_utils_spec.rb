require 'lang_utils'

describe String do
	describe "#compact!" do

		it "should strip out whitespace on either end" do
			string = "
			  here is a string
			 with space
			"
			string.compact!.should =~ /^\S+.*\S+$/
		end

		it "should eliminate newlines" do
			string = "here is text\n split onto two lines"
			string.compact!.should == "here is text split onto two lines"
		end

		it "should eliminate leading whitespace (replace with a single space)
		for the second line" do
			string = "so i blah blah
					and then I blah some more"
			string.compact!.should == "so i blah blah and then I blah some more"
		end

		it "should eliminate leading whitespace (replace with a single space)
		for lines beyond the second whose leading whitespace matches the
		preceeding line" do
			string = "so I blah blah
					and then I blah some more
					and lo, I continue to blah
					and so on, and so forth."
			string.compact!.should == "so I blah blah and then I blah some " +
									"more and lo, I continue to blah and " +
									"so on, and so forth."
		end
	end
end


describe Regexp do
	describe "|" do
		it "should join /foo/ and /bar/ into /(?:foo)|(?:bar)" do
			(/foo/ | /bar/).should == /(?:foo)|(?:bar)/
		end

		it "should preserve options (such as /i and /m)" do
			(/foo/i | /bar/i).options.should == (//i).options
		end

		it "should throw an error if options don't match" do
			lambda {
				/foo/ | /bar/i
			}.should raise_error(UnmatchedOptionsError)
		end
	end
end
