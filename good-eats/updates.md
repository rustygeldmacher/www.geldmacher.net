---
layout: good_eats
---

{% for post in site.tags.season_4 %}

<h3>{{ post.date | date: "%B %d, %Y" }}</h3>

<h2>{{ post.title }}</h2>

{{ post.content }}

{% good_eats_recipe_notes post: post %}

{% endfor %}
