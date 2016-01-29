post '/saved_phrase' do 
  session[:current_phrase] = Sentence.sentence_creator
  redirect '/'
end

post '/saved_phrases' do 
  @saved_phrase = SavedPhrase.new(
    collection_id: Collection.find_by(user_id: current_user.id).id,
    phrase: session[:current_phrase])
  begin
    @saved_phrase.save!
    session[:current_phrase] = nil
  rescue ActiveRecord::RecordInvalid
    session[:field_blank] = true
  end
  redirect '/'
end

delete '/saved_phrase/:id' do 
  SavedPhrase.delete(params[:id])
  redirect "users/#{session[:user]}/collection"
end

delete '/saved_phrases' do 
  Collection.find_by(user_id: current_user.id).saved_phrases.destroy_all
  redirect "users/#{session[:user]}/collection"
end