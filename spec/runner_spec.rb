require 'spec_helper'

describe Engage::Runner do
  describe "a plain project" do
    subject { Engage::Runner.new(["lucasmazza/engage"]) }

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
end