require "spec_helper"

describe MailNotifier do
  describe "registered" do
    let(:mail) { MailNotifier.registered }

    it "renders the headers" do
      mail.subject.should eq("Registered")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
