When you fetched down, you should have a new file called `routes/graduation.rb`.  It declares a single route, and it points to the post.erb file.


```


get '/graduation' do
    erb :"graduation/post", layout: :"graduation/layout"
  # Page where user can log in
end

```


Go ahead and use `rake serve` to see what the '/graduation' route looks like.

For graduation, we would like you to share your experience in creating this project.  Often with back end code, the coolest part is not what is on the screen.

Explain the steps you took to get here, and you built your project.  This is what we will share with our friends and family on graduation night.

Take some time to write what you have done in SheQL.