class PagesController < ApplicationController
    
    def home
        @articles = Article.order("created_at DESC")
    end
    
    def about
    end
    
    def search
        if params[:search].blank?  
            redirect_to(root_path, alert: "Please type something is searchbox!") and return  
        else
            @articles = Article.where("lower(title) LIKE :title1", {:title1 => "%#{params[:search].downcase}%"}).paginate(page: params[:page], per_page: 5)
        end
    end
    
end
