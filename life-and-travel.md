---
title: life & travel
layout: page
---

<ul>
 {% for post in site.tags.life_and_travel %}
 <li>
 		{{ post.date | date: "%B %e, %Y" }} - <a href="{{ post.url }}">{{ post.title }}</a>
 </li>
 {% endfor %}
</ul>
