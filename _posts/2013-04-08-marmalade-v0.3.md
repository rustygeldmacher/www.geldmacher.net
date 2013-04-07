---
date: 2013-04-08
layout: post
title: Marmalade v0.3
tags: tech
---

Just in time for [Code Jam 2013](https://code.google.com/codejam/), I've pushed a new version of [Marmalade](https://github.com/rustygeldmacher/marmalade) to RubyGems. This version introduces the ability to run your test cases in parallel.

In Code Jam, it's critical to submit your results as quickly as possible. At the same time, though, often the most straightforward way to solve a puzzle is by using brute force rather than taking the time to figure out the most elegant or efficient algorithm. Unfortunately, since brute force often means slow execution, these two factors are at odds with each other.

To help with this, Marmalade 0.3 takes advantage of Michael Grosser's excellent ['parallel' gem](https://github.com/grosser/parallel), allowing you to run your test cases using all available CPU cores.

To see how this could help, let's look at the [Rope Intranet](https://github.com/rustygeldmacher/marmalade/tree/master/examples/rope-intranet) example solution. For this particular puzzle, we bascially brute force the solution by testing every wire against all the other wires. Running this on my i7 with four cores, I get the following results:

    rope-intranet$ time ./rope-intranet.rb -f A-large-practice.in
    Case #1: 2
    Case #2: 0
    ...
    Case #14: 241081
    Case #15: 0

    real	0m16.124s
    user	0m16.080s
    sys	0m0.037s

However, when running the solution we're only using one out of the four cores available to us. It follows that we can probably do better with this example. Using the latest version of Marmalade, we can have it run up to 4 test cases in parallel at any time:

    rope-intranet$ time ./rope-intranet.rb -f A-large-practice.in --parallel
    Case #1: 2
    Case #2: 0
    ...
    Case #14: 241081
    Case #15: 0

    real	0m4.860s
    user	0m31.222s
    sys	0m0.192s

We now get our solution in almost a quarter of the time. Of course, the difference between 16 seconds and 4 seconds isn't all that much, but for some puzzles parallel execution can mean the difference between getting your submission through in time or not.

I know having this would have helped me last year, so hopefully it can help someone this time around. Good luck in Code Jam 2013!
