title 'Jenga Acceptance Test'

describe http('http://localhost') do
  its('status') { should cmp 200 }
  its('body') { should include('<h1>Welcome to nginx!</h1>') }
end

describe http('http://localhost:8080') do
  it 'should return 200 OK' do
    expect(subject.status).to eq 200
  end

  it 'should have correct content type' do
    expect(subject.headers['Content-Type']).to include('text/html')
  end

  it 'should return expected content header' do
    expect(subject.body).to include('<h1>Welcome to Jenga App</h1>')
  end

  context 'Response Body' do
    let(:body) do
      subject.body.match(%r{<pre>(.*?)</pre>}m)[1].to_s.strip
    end
    let(:body_lines) { body.split("\n").map(&:strip) }

    it 'should not be empty' do
      expect(body_lines).not_to be_empty
    end

    it 'should contain correct Hostname in response on position 0' do
      expect(body_lines[0]).to eq("Hostname: #{Socket.gethostname}")
    end

    it 'should contain correct IP Address in response on position 1' do
      expect(body_lines[1]).to eq("IP Address: #{IPSocket.getaddress(Socket.gethostname)}")
    end

    it 'should contain Last Chef Run in response on position 2' do
      expect(body_lines[2]).to match(/Last Chef Run: /)
    end

    it 'should contain correct Last Chef PID in response on position 3' do
      last_chef_pid_file = File.read('.chef/cache/chef-client-running.pid')
      expect(body_lines[3]).to eq("Last Chef PID: #{last_chef_pid_file}")
    end
  end
end
