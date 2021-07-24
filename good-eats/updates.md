---
layout: good_eats
---

{% for post in site.tags.goodeats %}

## {{ post.date | date: "%B %d, %Y" }} - {{ post.title }}

{{ post.content }}

{% endfor %}
