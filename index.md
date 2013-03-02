---
title: rusty's home on the web
layout: default
body_class: home
---

## latest

<ul>
	{% for post in site.posts limit: 3 %}
	<li>{{ post.date | date: "%B %e, %Y" }} &mdash; <a href="{{ post.url }}">{{ post.title }}</a></li>
	{% endfor %}
</ul>

## hiking

* [4000 footer list and summit info](/4000-footers/) - Chronicling the quest to summit all 4,000+ foot peaks in New Hampshire's White Mountains.
* [All hike reports](/hikes.html) - 4000 footers and otherwise

## life & travel

Dispatches and reports from my life and times

* [Travels and other updates](/life-and-travel.html)

## projects & experiments

* [marmalade](https://github.com/rustygeldmacher/marmalade) - Ruby framework and DSL for Google Code Jam puzzles
* [canvas life](http://life.geldmacher.net) - Implementation of Conway's Game of Life in JavaScript and HTML canvas
 * [superlinks](https://github.com/rustygeldmacher/marmalade) - Small WordPress plugin to add links to the sidebar

{% sidebar %}

<ul class="service-links">
	<li><a href="https://twitter.com/geldmacher"><img src="/images/twitter.png" /></a></li>
	<li><a href="https://github.com/rustygeldmacher"><img src="/images/github.png" /></a></li>
	<li><a href="http://www.linkedin.com/pub/rusty-geldmacher/2/8a6/647"><img src="/images/linkedin.png" /></a></li>
	<li><a href="http://www.flickr.com/photos/geldmacher"><img src="/images/flickr.png" /></a></li>
	<li><a href="/rss.xml"><img src="/images/rss.png" /></a></li>
</ul>

<p class="hidden-phone">
	<small><em>russell dot geldmacher at gmail dot com</em></small>
</p>

{% endsidebar %}
