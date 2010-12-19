module Helpers

  def run
    silenced(:stdout) { subject.invoke_all }
  end
  
  def stub_commands
    subject.stub(:system).and_return(true)
  end
  
  def expect(command)
    subject.should_receive(:system).with(command)
  end

  def dont_expect(command)
    subject.should_not_receive(:system).with(command)
  end

  
  def silenced(stream)
      begin
        stream = stream.to_s
        eval "$#{stream} = StringIO.new"
        yield
        result = eval("$#{stream}").string
      ensure
        eval("$#{stream} = #{stream.upcase}")
      end

      result
    end
  
end