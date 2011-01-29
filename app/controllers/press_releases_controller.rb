class PressReleasesController < ApplicationController

  def index
    @press_releases = PressRelease.all
  end
end
