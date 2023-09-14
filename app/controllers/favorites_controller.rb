class FavoritesController < ApplicationController
    
    def create
        book = Book.find(params[:book_id])
        favorite = current_user.favorites.new(book_id: book.id)
        favorite.save
        if request.referer == book_url(book)
            redirect_to book_path(params[:book_id])
        elsif request.referer == user_url(current_user)
            redirect_to user_path(current_user)
        else
            redirect_back(fallback_location: books_path)
        end
        
    end
    
    def destroy
        book = Book.find(params[:book_id])
        favorite = current_user.favorites.find_by(book_id: book.id)
        favorite.destroy
        if request.referer == book_url(book)
            redirect_to book_path(params[:book_id])
        elsif request.referer == user_url(current_user)
            redirect_to user_path(current_user)
        else
            redirect_back(fallback_location: books_path)
        end
    end
    
end
