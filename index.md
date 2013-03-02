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

* marmalade
* canvas life

{% sidebar %}

* twitter
* linkedin
* github
* flickr

<small><em>russell dot geldmacher at gmail dot com</em></small>

{% endsidebar %}
