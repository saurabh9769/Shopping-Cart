desc 'my wishlist email'
task my_wishlist_email: :environment do
    @wishlist = UserWishList.all
    UserMailer.my_wishlist_email(@wishlist).deliver!
end