# StaticSearch

StaticSearch allow you to index your static content (i.e "pages") in your Rails app easily!. Why would you want to index static pages? You can search the content within it, generate analytics etc.
It's made of 2 modules - Indexing and Searching.

#### Keep In mind:
This gem is currently a work in progress and it is not a part of the Rubygem site. I am using it currently for a specific project and I change stuff on the fly. Once I feel it's stable enough, I will release it to the world


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'static-search'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install static-search

Run the migration:

	$ rake db:migrate

## Usage
### Indexing
First make sure all of your static pages are in the right place:

	- app/
	  - views/
	    - pages/
		    - index.html
		    - about.html.erb
		    - faq.html
		    - privacy_policy.html

Now, you are able to run the built-in rake task:

	$ rake static:index


The output should be something like that

	Indexing index
	Indexing about
	Indexing faq
	Indexing privacy_policy
	-- Completed

If	you made a change in the content and you want to update the index, simply run the rake task again and it will update everything.

At this point, the content (text) of the page, including parsed erb, is saved in the database *without* the html tags.

### Searcing

TODO: Build search module.

## Contributing

1. Fork it ( https://github.com/danielravina/static_search/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request