---
layout: good_eats
---

## Frequently Asked Questions

### What do the ratings mean?

I’ve decided to rate recipes on two factors: crowd pleasing and ease of
preparation.

Crowd pleasing is the average rating given by the folks who ate the
recipe, usually my family plus me. Since more often than not I’m cooking
for my family, tracking this rating seems to make sense. Crowd pleasing
is on a scale of 1 to 5:

-   1 = Gross. Disgusting. Sad I ate this at all.
-   2 = Meh. I don’t hate it, but I don’t like it either.
-   3 = Good. Would probably eat this again.
-   4 = Great. Definitely want to make this again.
-   5 = Amazing. A new family favorite.

Ease of preparation takes a bunch of stuff into account: prep time,
equipment setup, difficulty of technique, messiness and cleanup, and so
forth. It all adds up the amount of effort it takes to make any
particular recipe. Like crowd rating, ease is scored on a five-point
scale:

-   1 = A total pain to make.
-   2 = Above average effort needed.
-   3 = About the average of of effort.
-   4 = Less effort than normally needed for a recipe.
-   5 = A total breeze.

### How do you pick what recipes to make vs. not make?

Some shows have recipes that are more like techniques instead. One
example is hard boiled eggs, which I’ll skip because it’s more about
that technique than it is a recipe (the big clue being that the
ingredient list is one: eggs). Some other recipes are just minor
modifications on another recipe from the show, with added ingredients or
alternate proportions (one example is scones and short bread from the
biscuits episode). When these recipes come around I feel OK about
skipping them.

### How did you get all the recipes links per season, etc?

It wasn’t easy!

At first I figured I’d just go over to the [Food Network Good Eats home
page](https://www.foodnetwork.com/shows/good-eats/episodes) and grab
each recipe link by episode. I quickly found out, though, that the Food
Network Good Eats page is full of errors: season/episode numbers are
messed up, sometimes only one or two recipes from an episode are listed,
some recipes are attributed to the wrong episode (and season), and some
episodes are completely missing. A lot of this is understandable since
Good Eats is over 20 years old and these pages have been maintained for
a long time.

The Food Network recipe pages are great, though, so I still wanted to
use them whenever I could. The trouble was finding an accurate list of
each episode’s recipes.

My next idea was to get each recipe per episode from the classic [Good
Eats Fan Page episode
index](http://www.goodeatsfanpage.com/gefp/episodebyorder.htm). GEFP has
a page for each episode, complete with a list of each recipe from the
episode linked to its Food Network recipe page. However, there are some
problems here, too. First, it only goes up to Season 14 (a few
post-Season 14 specials are labeled as Season 15), so I’d have to get
Seasons 15 an 16 somewhere else. Second, and more importantly, Food
Network changed its URL structure at some point, so every recipe link on
GEFP is broken. Oof.

However – the recipe lists per episode are comprehensive and carefully
curated, so I still wanted to use those as my source. I figured that
page was active and popular in its day, so the lists should be complete.
Thankfully, the recipe names on GEFP and Food Network are a perfect
match 99% of the time, so I could use that.

The final issue was the fact that GEFP and Food Network use different
episode numbering schemes and sometimes even different episode titles.
I’d already spent hours on this so I wanted the episode ordering to be
correct. For the correct order I turned to the [Wikipedia Good Eats
Episode list](https://en.wikipedia.org/wiki/List_of_Good_Eats_episodes).
That page seems to have the canonical ordering, so I used that as the
source of truth.

Putting it all together, I wrote up some web scraper code to put
together the complete recipe index. It works like this:

-   **Gather data**
    -   Get the season and episode listing from Wikipedia
    -   Get recipe links episode-by-episode from FoodNetwork.com
    -   Get recipe links from the [Food Network Good Eats recipe
        index](https://www.foodnetwork.com/shows/good-eats/recipes)
        (yes, there are recipes in that index that aren’t linked to from
        the show pages, and vice versa, so both indices are needed)
    -   Get the list of recipes-per-episode from Good Eats Fan page
        episode pages
-   **Put it together**
    -   Go through Wikipedia list, episode by episode
    -   Get the episode’s recipe list from GEFP
    -   Get the recipe links from Food Network, first trying the recipes
        from the episode and falling back to the complete index.
    -   For Seasons 15 and 16, we have to trust that what Food Network
        has listed as the episode’s recipes is correct, which I’m more
        willing to believe than for the 20+ year old episodes.

When all is said and done, the whole thing spits out the [complete
recipe index](recipes.html) that you see here on this site. Whew!

### What about Good Eats: Reloaded?

Some of the “reloaded” episodes feature completely different recipes
than the original episodes, and in those cases I’ll skip the reloaded
ones. Sometimes, though they feature “fixed” recipes, for instance the
fondue recipe from season one. In those cases I’ll probably use the
reloaded recipe, especially since Alton says the original recipe barely
even works. My main goal, though it to follow the original episodes as
closely as I can.

### What about the specials?

I’m going to skip those for now, but might come back to them at some
point.

### Hasn’t this been done before?

Most definitely. One example is [Allison Cooks Good Eats](https://allisoncooksgoodeats.com/), where she’s
going episode-by-episode through the show. I’ve been referencing her
entries for tips and stuff on the recipes. For instance, I didn’t
realize that sometimes the recipe in the show differs from the recipe
online.
