# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  def index
    @pattern = params[:q]

    @objects = ActsAsFerret.find(params[:q] || '', 'shared')
  end
end
