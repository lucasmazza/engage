require 'spec_helper'

describe Engage::Runner do
  before { stub_commands }

  describe "#init" do
    context "with a full featured project" do
      before do
        subject.stub(:using_bundler?) { true }
      end

      it "clones the git repository" do
        expect_command "git clone git@github.com:lucasmazza/engage.git"
        subject.init('lucasmazza/engage')
      end

      it "creates a gemset with the project name" do
        expect_command "rvm gemset create engage"
        subject.init('lucasmazza/engage')
      end

      it "creates a `.rvmrc` file" do
        subject.init('cyberdyne/skynet')
        File.exists?("skynet/.rvmrc").should be_true
      end

      it "trusts the created `.rvmrc` file" do
        expect_command "rvm rvmrc trust skynet"
        subject.init("cyberdyne/skynet")
      end

      it "runs the `bundle` command" do
        expect_command "cd skynet && rvm 1.8.7@skynet exec bundle"
        subject.init("cyberdyne/skynet")
      end
    end

    context "a project without a gemfile" do
      before do
        subject.stub(:using_bundler?) { false }
      end

      it "doesn't run the `bundle` command" do
        dont_expect_command "cd oldapp && rvm 1.8.7@oldapp exec bundle"
        subject.init('oldstuff/oldapp')
      end
    end

    context "when there's only one available source" do
      it "doesn't ask the user to select a source" do
        subject.should_not_receive(:ask).with("Select the git source of 'rails':")
        subject.init("rails/rails")
      end
    end

    context "when there's more than one available source" do
      before do
        subject.add('git@omgwtfbbq.com')
      end

      it "outputs the available sources" do
        subject.should_receive(:list)
        subject.init('rails/rails')
      end

      it "asks the user to select one source" do
        subject.should_receive(:ask).with("Select the git source of 'rails':")
        subject.init('rails/rails')
      end

      it "clones from the selected source" do
        subject.stub(:ask) { 1 }
        expect_command "git clone git@omgwtfbbq.com:rails/rails.git"
        subject.init('rails/rails')
      end
    end
  end

  describe "#list" do
    it "prints a banner" do
      subject.should_receive(:say).with('Available sources:')
      subject.list
    end

    it "outputs all the registered sources" do
      subject.should_receive(:print_table)
      subject.list
    end
  end

  describe "#add" do
    context "when the source isn't registered" do
      it "registers the given source" do
        expect { subject.add("git@acme.com") }.to change(subject, :sources)
      end

      it "outputs a confirmation message" do
        subject.should_receive(:say_status).with('added source', 'git@acme.com', :green)
        subject.add("git@acme.com")
      end
    end

    context "when the source is duplicate" do
      before { subject.add("git@mycompany.com") }
      it "doesn't register the given source" do
        expect { subject.add("git@mycompany.com") }.to_not change(subject, :sources)
      end

      it "outputs a warnning message" do
        subject.should_receive(:say_status).with('duplicate', 'git@mycompany.com', :red)
        subject.add("git@mycompany.com")
      end
    end
  end
end