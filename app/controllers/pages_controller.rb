class PagesController < ApplicationController
    
    def home
        @articles = Article.order("created_at DESC")
    end
    
    def about
    end
end
