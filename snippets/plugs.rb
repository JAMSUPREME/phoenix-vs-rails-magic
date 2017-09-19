
class ApplicationController
  before_action :authenticate_user
  before_action :authorize_user
end

class CatController < ApplicationController
  skip_before_action :authenticate_user, :only => :show
  skip_before_action :authorize_user, :only => :show
end

class PurchaseCatController < CatController
  before_action :fill_cat_data
end