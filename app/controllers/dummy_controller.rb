class DummyController < ApplicationController
  def index
    render inline: "Hello World"
  end
end
