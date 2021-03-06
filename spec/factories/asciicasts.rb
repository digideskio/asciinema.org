# Read about factories at http://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess

FactoryGirl.define do
  fixture_file = lambda { |name, mime_type|
    Asciinema::FixtureHelpers.fixture_file(name, mime_type)
  }

  factory :asciicast do
    version 1
    association :user
    title "bashing"
    duration 11.146430015564
    terminal_type "screen-256color"
    terminal_columns 96
    terminal_lines 26
    shell "/bin/zsh"
    views_count 1
    file { fixture_file['1/asciicast.json', 'application/json'] }
    stdout_frames { fixture_file['stdout.json', 'application/json'] }
    snapshot JSON.parse(File.read('spec/fixtures/snapshot.json'))
  end

  factory :legacy_asciicast, parent: :asciicast do
    version 0
    file nil
    stdout_data { fixture_file['0.9.9/stdout', 'application/octet-stream'] }
    stdout_timing { fixture_file['0.9.9/stdout.time', 'application/octet-stream'] }
    uname 'Linux 3.9.9-302.fc19.x86_64 #1 SMP Sat Jul 6 13:41:07 UTC 2013 x86_64'
  end
end
