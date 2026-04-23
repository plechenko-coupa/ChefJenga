title 'Jenga Acceptance Test'

describe http('http://localhost') do
  its('status') { should cmp 200 }
  its('body') { should include('<h1>Welcome to nginx!</h1>') }
end

describe http('http://localhost:8080') do
  it 'should return 200 OK' do
    expect(subject.status).to eq 200
  end

  it 'should return expected content' do
    expect(subject.body).to include('<h1>Welcome to Jenga App</h1>')
  end

  it 'should have correct content type' do
    expect(subject.headers['Content-Type']).to include('text/html')
  end

  it 'should contain correct hostname in response' do
    expect(subject.body).to include("Hostname: #{Socket.gethostname}")
  end

  it 'should contain Last Chef Run in response' do
    expect(subject.body).to include('Last Chef Run:')
  end
end
