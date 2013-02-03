---
title: rusty's home on the web
layout: default
---

## hiking

<ul>
{% for page in site.pages reversed %}
  {% if page.layout == 'hike' %}
		<li>{{ page.title }}</li>
	{% endif %}
{% endfor %}
</ul>

## life and travel

## other
