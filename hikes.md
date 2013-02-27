---
title: hikes
layout: page
---

<ul>
 {% for hike in site.tags.hike %}
 <li>
 		<a href="{{ hike.url }}">{{ hike.title }}</a> - {{ hike.date | date: "%B %e, %Y" }} - {{ hike.location }}
 </li>
 {% endfor %}
</ul>
