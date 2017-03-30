require 'test_helper'

class AllowFailureGitTest < Test::Unit::TestCase

  def test_allowed_failure
    Hatchet::GitApp.new("no_lockfile", allow_failure: true).deploy do |app|
      refute app.deployed?
      assert_match "Gemfile.lock required", app.output
    end
  end

  def test_failure_with_no_flag
    FileUtils.mkdir('no_lockfile') unless File.exists?('no_lockfile')

    assert_raise(Hatchet::App::FailedDeploy) do
      Hatchet::GitApp.new("no_lockfile").deploy
    end

    FileUtils.rm_r('no_lockfile')
  end
end
