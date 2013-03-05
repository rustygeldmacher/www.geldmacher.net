---
date: 2013-03-05
layout: post
title: Introducing jekyll-contentblocks
tags: tech
---

When I recently rewrote my site using [Jekyll](http://jekyllrb.com/), one thing I really missed was having something like Rails' `content_for` mechanism. Using `content_for`, a page can inform its parent layout about content that needs to be put in various places on the rendered page. A couple of popular examples are:

* Specifying content for the sidebar
* Adding JavaScript or CSS files into the page's `<head>` section

I saw a few implementations out there of this kind of functionality for Jekyll, but some were too specific (i.e. sidebar only), others didn't seem to work with the latest version of Jekyll, and still others worked but did not allow for Markdown within the blocks.

Thus was born the [jekyll-contentblocks plugin](https://github.com/rustygeldmacher/jekyll-contentblocks).

The plugin introduces two new Liquid tags: `contentblock` and `contentfor`. Here's an example of how they are used. Say we have a layout, `_layouts/default.html`:

{% highlight html %}
<html>
  <head>
  	<title>{% raw %}{{ page.title }}{% endraw %}</title>
  	<link rel="stylesheet" href="/css/main.css" />
        {% raw %}{% contentblock styles %}{% endraw %}
  </head>
  <body>
  	<div class="main">
  	  {% raw %}{{ content }}{% endraw %}
  	</div>
  	<div class="sidebar">
  	  {% raw %}{% contentblock sidebar %}{% endraw %}
  	</div>
  </body>
</html>
{% endhighlight %}

This layout defines two places where a page can add content: `styles` and `sidebar`.

Now let's say we want to include a specific set of CSS styles specific to posts. To do that, we define our `_layouts/post.html` layout like this:

{% highlight html %}
---
layout: default
---

{% raw %}{% contentfor styles %}{% endraw %}
  <link rel="stylesheet" href="/css/posts.css" />
{% raw %}{% endcontentfor %}{% endraw %}

{% raw %}{{ content }}{% endraw %}
{% endhighlight %}

Using the `contentfor styles` Liquid block like above would pull the `posts.css` file into every page using the `post` layout. Now, if we have a post that wants to include some content in the sidebar, we can simply create a file like `_posts/a-post.md`:

{% highlight html %}
---
layout: post
---

Here is my post content.

{% raw %}{% contentfor styles %}
* here is a markdown list
* that will be rendered into the sidebar
* for the post "{{ page.title }}"
{% endcontentfor %}{% endraw %}

{% endhighlight %}

As you can see, the `contentfor` blocks can render Markdown (or whatever the current file format is) and they will render Liquid tags within them.

So that's basically it -- please give the plugin a try in your own Jekyll project and let me know on [the plugin's GitHub page](https://github.com/rustygeldmacher/jekyll-contentblocks) if you encounter any issues!
