get '/:user_permalink/:depth' do
  @track_ids = Scraper.scrape(params[:user_permalink],params[:depth].to_i)
  erb :home
end