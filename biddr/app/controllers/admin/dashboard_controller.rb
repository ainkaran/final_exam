class Admin::DashboardController < Admin::BaseController
  @auctions = Auction.all
  @bids = Bid.all
  @users = User.all
end
