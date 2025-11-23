---
title: rusty's home on the web
layout: default
body_class: home
---

## latest

<ul>
	{% for post in site.posts limit: 3 %}
	<li>{{ post.date | date: "%B %e, %Y" }} &mdash; <a href="{{ post.url }}">{% if post.tags contains 'goodeats' %}Good Eats: {% endif %}{{ post.title }}{{ post.tags.inpsect }}</a></li>
	{% endfor %}
</ul>

## projects & experiments

* [he built well](https://hebuiltwell.geldmacher.net) - Digitized version of my great-great-great-great-grandfather's autobiography and genealogy
* [good eats](good-eats/) - Attempting to cook my way through Good Eats
* [flickr_to_google_photos](https://github.com/rustygeldmacher/flickr_to_google_photos) - A command line tool to help you move your Flickr albums to Google Photos
* [jekyll-contentblocks](https://github.com/rustygeldmacher/jekyll-contentblocks) - Jekyll plugin giving you something similar to content_for in Rails
* [canvas life](http://life.geldmacher.net) - Implementation of Conway's Game of Life in JavaScript and HTML canvas

## hiking

* [4000 footer list and summit info](/4000-footers/) - Chronicling the quest to summit all 4,000+ foot peaks in New Hampshire's White Mountains.
* [All hike reports](/hikes.html) - 4000 footers and otherwise


{% contentfor sidebar %}

<ul class="service-links">
	<li><a href="https://github.com/rustygeldmacher"><img src="/images/github.png" /></a></li>
	<li><a href=" https://www.linkedin.com/in/rusty-geldmacher/"><img src="/images/linkedin.png" /></a></li>
	<li><a href="/rss.xml"><img src="/images/rss.png" /></a></li>
</ul>

<p class="hidden-phone">
	<small><em>russell dot geldmacher at gmail dot com</em></small>
</p>

{% endcontentfor %}
