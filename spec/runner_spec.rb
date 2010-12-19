require 'spec_helper'

describe Engage::Runner do
  subject { Engage::Runner.new(["lucasmazza/engage"]) }
  before { stub_commands }
  context "Starting projects" do

    context "a full featured project" do
      before do
        subject.stub(:using_bundler?) { true }
      end
      it "clones the given github repository" do
        expect "git clone git@github.com:lucasmazza/engage.git"
        run
      end
    
      it "creates a gemset based on the project name" do
        expect "rvm gemset create engage"
        run
      end
    
      it "runs bundler command" do
        expect "cd engage && bundle"
        run
      end
    end
  
    context "a project without a gemfile" do
      before do
        subject.stub(:using_bundler?) { false }
      end

      it "doesn't run the bundler command" do
        dont_expect "cd engage && bundle"
        run
      end
    end
  
    context "a project from another git server" do
      subject { Engage::Runner.new(["random_company_project"]) }

      before do
        subject.stub(:sources) { ["foo@bar.com", "git@acme.com"] }
        subject.stub(:ask) { 1 }
      end
      
      it "asks for the selected git source" do
        subject.should_receive(:ask).with("Select the server of 'random_company_project':")
        run
      end

      it "clones the repo from the selected server" do
        expect "git clone git@acme.com:random_company_project.git"
        run
      end
    end
  end
  
  context "Writing sources" do
    it "accepts a partial url"
    it "accepts a partial url and a description"
  end
end