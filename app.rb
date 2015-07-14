
class App < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :logging, true
  enable :sessions

  get "/" do
    redirect "/init"
  end
  
  get "/init" do
    session[:cards]=[]
   (1..10).each do |v|
     ["Spades","Clubs", "Diamonds","Hearts" ].each_with_index do |s,i|
       session[:cards] << ["#{v} of #{s}", v.to_f + (i/10.0)]
     end

   end
     {"Jack"=>11, "Queen"=>12, "King" => 13}.each do |c,v|
       ["Spades","Clubs", "Diamonds","Hearts" ].each_with_index do |s,i|
         session[:cards] << ["#{c} of #{s}", v.to_f + (i/10.0)]
       end
     end
    session[:cards].shuffle!
    session[:card]=session[:cards].pop
    session[:guess]=0
    redirect "/play"
  end

  get "/play" do
    
    "On the deck there is a #{session[:card][0]} (#{session[:card][1]}). </br> The Deck has #{session[:cards].size} cards </br> Next is  <a href='#{url '/bet/upper'}'>upper</a> or <a href='#{url '/bet/lower'}'>lower</a>"
  end

  get "/bet/:guess" do
    current_card=session[:card].dup
    session[:card]=session[:cards].pop
    if params[:guess]=="upper" && session[:card][1] > current_card[1]
      session[:guess]+=1
      redirect "/play"
    elsif params[:guess]=="lower" && session[:card][1] < current_card[1]
      session[:guess]+=1
      redirect "/play"
    else
      "You lose! You bet on #{params[:guess]} of #{current_card[0]}  (#{current_card[1]})  but next card was #{session[:card][0]}  (#{session[:card][1]}). <a href='#{url '/init'}'>Play Again</a>? "
    end
  end


end
