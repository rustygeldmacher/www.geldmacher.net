---
date: 2005-10-21
layout: page
title: 4000 Footers
---

**Completed: July 3, 2010**

In August of 2003, [Dan](http://www.littlebigmind.com) and I decided that we wanted to summit all 48 peaks in New Hampshire's White Mountains that were 4000 feet or higher. On July 3, 2010 we finished this seven-year project, gaining entry into the [AMC 4000 Footers Club](http://www.amc4000footer.org/), which recognizes this significant achievement. Here on this page, I've documented my progress by listing the dates which I've summited and linking into pictures from the hikes that got me there.

<table class="table table-striped" id="summits">
	<thead>
		<tr>
			<th class="header">Rank</th>
  		<th class="header">Peak</th>
  		<th class="header">Height</th>
  		<th class="header">Summited</th>
  		<th class="header">Photos</th>
		</tr>
	</thead>
	<tbody>
		{% for summit in page.summits %}
			<tr>
				<td>{{ forloop.index }}</td>
				<td><a href="{{ summit.page }}">{{ summit.name }}</a></td>
				<td>{{ summit.height }}</td>
				<td>{{ summit.summited }}</td>
				<td><a href="{{ summit.gallery }}"><img src="{{ summit.thumbnail }} "/></a></td>
			</tr>
		{% endfor %}
	</tbody>
</table>

Dan and I both agreed we would completely start over from anything we've previously done. Therefore, the list begins with the summit of Mt. Madison from August 2003.

### Peaks per year:

<table class="table table-striped" id="summary">
	<thead>
		<th class="header">Year</th>
		<th class="header">Number of Peaks</th>
	</thead>
	<tbody>
		<tr><td>2003</td><td>1</td></tr>
		<tr><td>2004</td><td>5</td></tr>
		<tr><td>2005</td><td>6</td></tr>
		<tr><td>2006</td><td>16</td></tr>
		<tr><td>2007</td><td>10</td></tr>
		<tr><td>2008</td><td>7</td></tr>
		<tr><td>2009</td><td>2</td></tr>
		<tr><td>2010</td><td>1</td></tr>
	</tbody>
</table>

<script type="text/javascript">
	$(function() {
		$('table#summits').tablesorter();
		$('table#summary').tablesorter();
	});
</script>
