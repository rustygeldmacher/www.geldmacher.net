---
layout: good_eats
body_class: good-eats
---

## Previously Completed Seasons

{% for season in (1..5) reversed %}
### Season {{ season }}

{% good_eats_season_table season %}
{% endfor %}

<script type="text/javascript">
  $(function() {
      $('.main table').tablesorter();
  });
</script>
