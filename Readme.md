#Hackershout

Shout your hackerness to the world!

Hackershout lets you promote your open-source work on the major Ruby (and geek
related) community blogs (Reddit, Hackernews and RubyFlow) via a nice command
line interface.

##Install

    $ gem install hackershout

##Notes

Through hackershout you publish an **URL** and a **text**. To link the URL from
the text you just have to use the special `<link>` tag. Note that for certain
sites, such as RubyFlow, you _have to link_ the URL from the text, since there
is no separate URL field. Hackershout will omit the special tag where it
doesn't need it (for example, in Reddit).

You can add additional links with normal HTML `<a>` tags.

Given `http://rubygems.org/gems/my_gem` as an URL, an example of a message
would be:

    Hey! I have released <link>some awesome open-source gem</link> that is
    going to save the world. Check it out! You can also grab the source code on
    <a href="http://github.com/me/my_gem">Github</a> if you want.

This will publish in Reddit like this:

    URL:  http://rubygems.org/gems/my_gem
    TEXT: Hey! I have released some awesome open-source gem that is going to
    save the world. Check it out! You can also grab the source code on
    <a href="http://github.com/me/my_gem">Github</a> if you want.

And on RubyFlow (where there is no separate URL field) like this:

    TEXT: Hey! I have released <a href="http://rubygems.org/gems/my_gem">some
    awesome open-source gem</a> that is going to save the world. Check it out!
    You can also grab the source code on <a href="http://github.com/me/my_gem">
    Github</a> if you want.

##Usage

    $ hackershout

    :: Welcome to hackershout! ::

    Type the URL you want to share: http://rubygems.com/gems/my_gem
    
    Type your message (two ENTERs to finish):
    Hey! I have released <link>some awesome open-source gem</link> that is
    going to save the world. Check it out! You can also grab the source code
    on <a href="http://github.com/me/my_gem">Github</a> if you want.(enter)
    (enter)
    Type some tags separated by comma (i.e. ruby, rails, bdd): ruby, parsing

    ...Got it! Now where would you want to spread the word?
      Ruby Reddit (y/n)? y
    Sorry, I don't have your Ruby Reddit credentials.
      E-mail: my.email@gmail.com
      Password: ********
    Saved! You won't have to enter your credentials for Ruby Reddit again.
      Hackernews (y/n)? y
      With 'my.other.email@gmail.com' right (y/n)? y
    Awesome!
      RubyFlow (y/n)? n
    Fine.
    Posting to Ruby Reddit...........ok
    Posting to Hackernews............ok

    Done. Happy hacking! :)

##Contribute!

* Fork the project.
* Make your feature addition or bug fix.
* Add specs for it. This is important so I don't break it in a future
  version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  If you want to have your own version, that is fine but bump version
  in a commit by itself I can ignore when I pull.
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Codegram. See LICENSE for details.
