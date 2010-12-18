require 'spec_helper'

describe Engage::Runner do
  subject { Engage::Runner.new(["lucasmazza/engage"]) }

  describe "a full featured project" do
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
  
  describe "a project without a gemfile" do
    before do
      subject.stub(:using_bundler?) { false }
    end

    it "doesn't run the bundler command" do
      dont_expect "cd engage && bundle"
      run
    end
  end
  
  describe "a project from another git server" do
    it "clones the repo from the selected server"
  end
end