class GuidesController < ApplicationController
  def book
    @books = ['Fountinhead', 'Deep Work', 'Rails Way']
  end
end