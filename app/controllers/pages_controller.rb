class PagesController < ApplicationController
  def home
    @contacts = Contact.accessible_by(current_ability)
  end
end