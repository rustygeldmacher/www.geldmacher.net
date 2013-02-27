---
title: rusty's home on the web
layout: default
body_class: home
---

## latest

<ul>
	{% for post in site.posts limit: 3 %}
	<li>{{ post.date | date: "%B %e, %Y" }} - <a href="{{ post.url }}">{{ post.title }}</a></li>
	{% endfor %}
</ul>

## 4000 footers

Chronicling the quest to summit all 4,000+ foot peaks in New Hampshire's White Mountains.

* [Full list and summit info](/4000-footers/)

## life & travel

Dispatches and reports from my life and times

* [Travels and other updates](/life-and-travel.html)
* [Hike reports](/hikes.html)

## projects & experiments

* marmalade
* canvas life

{% sidebar %}

* twitter
* linkedin
* github
* flickr

russell dot geldmacher at gmail dot com

{% endsidebar %}
