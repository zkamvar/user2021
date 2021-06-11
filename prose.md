# Using R as a Community Workbench for The Carpentries Lesson Infrastructure

This will be the prose of the talk that I will use as the source for the
transcript. Assuming an average 140 words per minute, this should contain no
more than 420 words per section.

> word count: ~2400 words; 160 wpm    
> timing 2021-06-09: 14:48.61 :grimace:    
> timing 2021-06-09: 15:05.77 :weary:    
> timing 2021-06-10: 13:53.36    

## Introduction

> timing 2021-06-09: 03:37.11
> timing 2021-06-09: 04:07.34
> timing 2021-06-10: 04:01.98


The Carpentries is a global organization of volunteers who strive to teach
foundational data and coding skills to researchers worldwide. What makes us
stand out is not the fact that we use evidence-based practices in teaching, it's
that we align all of our decisions with our core values which puts people first
and accepts all contributions.

Our lessons are all open-license websites built on a consistent style that
adheres to active learning principals. We use these lessons as the source
material for the hundreds of workshops we run each year and have three distinct
audiences:

1. The certified Carpentries instructor who uses it for reference material as
   they teach.
2. The learner in a Carpentries workshop who uses the lesson as a reference
   later on as they practice the materials.
3. The educator who wants to use these open-licensed materials for their own
   lessons.

The source for these lessons are hosted on GitHub were we have a core set of
volunteer maintainers to make sure that the information on the lesson is
accurate and up to date. It is in these repositories that we accept all
contributions from the community, whether it be simple typo fix or a better
explanation of an important lesson concept, anyone can go to the repository and
make a suggestion... at least that was our intention.

I want to pause for a second here and highlight this tweet that came across my
feed as I was preparing this talk.

<https://twitter.com/SarahNicholas/status/1401510907604353024?s=20>

It shows a fork between a paved path and an unpaved footpath across a patch of
grass, which leads to a crosswalk. There is a sign in front of the unpaved path
that says "Please use the purpose made path provided." The tweet author points
out that "the sign knows it has lost."

This unofficial footpath is called a "cowpath" or a "desire path" and it's a
very important concept in design because it shows the difference between what
the designers intended vs how people actually use the space.

As our community has grown, we've been noticing more and more of these desire
paths in our lesson infrastructure through issue comments, pull requests, and
slack threads and we realize that these issues will not be fixed by writing
better documentation, they can only be fixed by rethinking our infrastructure
all together in a way that is more inclusive and welcoming for all people,
including those who just want to write lessons and those who are interested in
the machinery behind it all.

We found that the R publishing ecosystem with pandoc is flexible enough to give
us all the tools we need **to reduce barriers for publishing lessons and
furthers our mission**. In this talk, I will introduce you to our current
infrastructure, it's unique challenges, our solutions, and how we used past and
present experiences from our community to iteratively refine our design.

And before I move on, I want to remind everyone of two things:

> There is no right or wrong, only better or worse
>
> --- GW

This quote by Greg Wilson was written after several iterations of the lesson
infrastructure and I put it here as a reminder that the infrastructure we have
right now was working for us at the time and what we come up with will have its
own difficulties down the road, but what is important is that we build something
that better addresses the needs of the community, which leads me to my second
reminder:

> In The Carpentries: you belong

As the community has grown, our infrastructure has been put to the test and we
have continuously updated our workflows to lower barriers for people. The reason
we do this is because our values are what drive us and in The Carpentries, you
belong, no matter if you have been working as a systems administrator for a
university HPC cluster or if you have just learned to write your first R script.
If you are unfamiliar with how we build our lessons, the next section is all
about our infrastructure.

## Infrastructure

> timing 2021-06-09: 04:20.38
> timing 2021-06-09: 03:52.10
> timing 2021-06-10: 03:08.87

Our lessons are written in markdown and translated to HTML via GitHub pages and
the Jekyll static site generator. The idea behind this choice was that it was
the most straightforward way to create a static website without needing a server
like wordpress or drupal sites. Ideally, it also provided a way for people to
use this as an example of how they could build their own website.

It's important to pause here and point out that the entire paradigm for this is
for people to be able to write markdown lessons and get a functional website
out of it. This is not a new concept, in fact, there are over 460 iterations of
this concept according to https://staticsitegenerators.net. Jekyll happens to
be the one that was used by GitHub early on and thus it stuck.

Of course, the default themes for Jekyll are focused on blog output, so we
created an all-in-one bundle for lessons that provided styling templates in
HTML, CSS, and JavaScript along with validation scripts in Python and R scripts
to build RMarkdown-based lessons. All of this was orchestrated by a Makefile.
The purpose of these tools were two-fold:

1. To maintain a consistent style that emphasize our principles of
   evidence-based teaching such as learning objectives and formative assessment
2. To demonstrate the how the skills we teach in our workshops can be applied
   to real-life situations.

While this was conceptually good in theory, this infrastructure design has two
significant drawbacks for contributors:

1. Installation pains.
   <https://twitter.com/gvwilson/status/1380115181708189701?s=20> Having
   Jekyll, Python, and Make as dependencies means that people who want to build
   these lessons need all three of these successfully installed and up-to-date on
   their machines. This is especially frustrating for Windows users who have none
   of these by default. Moreover, having all the tools living inside the
   repository meant that lessons quickly become out of date as we improve our
   infrastructure.
2. Another drawback is that we have a lesson website wrapped around a static
   site generator (which in and of itself is a kind of desire path), this meant
   that it was easy to contribute to if you were familiar with how Jekyll
   operated. Some would say Jekyll is well documented, but in my experience,
   Jekyll is well, documented. There is often a moment of panic in a new
   contributor's eyes when you show them what the a lesson repository looks like.
   If you were not familiar with Jekyll, then it was unclear where to even start
   if you were looking at the git repository because of all the exposed wiring
   with no signs that clearly say "start here". This aspect has lead to several
   lessons built in _slightly_ different ways.

This brings me back to the cowpaths. Over the last few years, we have
begun finding them from all across the lesson infrastructure popping up in
separate places that appear through issues, pull requests and general
frustration from contributors and maintainers alike. The thing about cowpaths,
though, is that they are not only challenges, but also opportunities, which we
like to call "chopportunities."

## Chopportunities

> timing 2021-06-09: 01:15.30
> timing 2021-06-09: 01:18.37
> timing 2021-06-10: 00:47.12

The growth that we've experienced in the past few years is a chopportunity.
We have seen not only a growth in the number of community members, but also,
with the carpentries incubator for community contributed lessons, we have seen
a vast growth in the number of lessons using the template.

Our challenge is clear: the all-in-one lesson infrastructure does not scale
well to the growing number of lessons under our umbrella, so we need to build
infrastructure that scales even better and separates the tools from the content.

Our opportunity here is to reimagine the infrastructure in a way that truly
values all contributions: this includes the spectrum from everyday educators
who do not feel "techy" to the tinkerers who need to understand what's going on
behind the scenes.

## Solution

> timing 2021-06-09: 04:47.01
> timing 2021-06-09: ~4.5-5 minutes
> timing 2021-06-10: ~5 minutes

As I mentioned in the beginning of my talk, we are using R for our solution and
here's how we got there.

### Challenge

We wanted a general solution where you could take markdown or RMarkdown files,
place them in a folder and generate a Carpentries-style lesson without having
complicated paths or generated files lying around. The first thing we did was
to look at prior art, or, what has been built before.

It was important that we choose something that was user friendly, easy to
install, easily customizable, and had a welcoming community behind it. We tried
out several static site generators, but the largest barrier for many of these
was that they were not easy to install and maintain.

Eventually, we settled on the fact that R is the best place to go for our needs
because of several reasons, but mostly:

1. First and foremost: R is chock-full of friendly communities!
  - RLadies
  - ROpenSci
  - RForwards
  - MiR
2. R comes as a binary that can be installed on all major operating systems and
   is available online via RStudio Cloud
3. R has a robust ecosystem for publishing thanks to {knitr} and RMarkdown

Once we identified R as our solution, the natural place to go was one of the
RMarkdown variants like blogdown or hugodown, but we found that while the tools
were indeed separated from the content and the documentation was rich and
accessible, there were many aspects that would not fit our model including the
presence of styling within the repository.

We realized that an unlikely contender, {pkgdown}, a documentation site
generator, used the same model that we were looking for: It meets people where
they are, content is pure markdown with no extra templating required, the tools
to build everything lived in a separate package, and it can be customized by
making your own package to host your CSS, JS, and HTML templates.

From this model, we created three packages to serve as the infrastructure tools,
styling, and validation:

 - {sandpaper} to orchestrate building and maintaining lessons
 - {varnish} to host the CSS, JS, and HTML templates
 - {pegboard} to serve as a validator (and converter!) for lesson content

When thinking about the lesson structure itself, we thought about what would
make sense for a maintainer or contributor when they saw the source files of
a website. We created a a folder structure that is reflected in the website
dropdown menus, so our lessons consist of folders that we use commonly: one
folder for lesson chapters, one for extra information for learners, one for
extra information for instructors, and one to contain learner profiles. The
final folder is one of the access panels that contains the rendered markdown
files---so you can use them in another context---and static website so that you
can put it on a USB stick and share it without needing to run a local server.

### Opportunity

Of course, our solution ticks all the boxes that satisfy our design choices in
that it's modular, but if we ended up designing something that R enthusiasts
love, but is unusable by newcomers, Python, or Matlab folks, then we are not
valuing all contributions.

Again, the whole point of this exercise is to get us back to a place where the
authors can focus on the content over the tools. We want to get back to a place
where people can place their markdown/RMarkdown/MyST notebooks in a folder and
create a lesson directly from these sources. It shouldn't matter what language
is used as long as it is usable. To do this, we needed to test the minimal
viable product on actual maintainers and we needed to make sure that they were
spread across the spectrum of

 - using R,
 - familiarity with the current infrastructure
 - familiarity with The Carpentries.

We recruited a total of 19 volunteers to run through the Alpha Test, which
tested the participants ability to install the infrastructure, create a lesson,
modify a lesson, and contribute to an existing lesson. After the tests, we
asked for 20 minute open-ended interviews about their experience with the new
tempalte to see what features people kept stumbling over. I want to take a
moment to thank the folks who have helped with the Alpha testing, some of whom
were part of The Carpentries core team. I don't have the time to go into detail
about the results, but a big takeaway from this was that everyone was able to
install the infrastructure and any problems that occured were from Git/GitHub,
which is a big improvement over the current system.

 - Angelique Trusler
 - Christina Koch
 - David Pérez-Suárez
 - Drake Asberry
 - Eric Jankowski
 - Erin Becker
 - Ezra Herman
 - Fan Du
 - François Michonneau
 - Jon Haitz Legarreta Gorroño
 - Karen Word
 - Kari Jordan
 - Maneesha Sane
 - Michael Culshaw-Maurer
 - Sarah Brown
 - Sarah Stevens
 - Shaun C. Gaynor
 - Toby Hodges
 - anonymous

## Conclusion

> timing 2021-06-09: 00:48.79
> timing 2021-06-09: ~ 1 minute
> timing 2021-06-10: ~ 1 minute

We have just barely finished with the alpha testing and the next phase for us is
to address all the questions and concerns that were brought up (for example: how
do I use this without clobbering the current R installation on my system?),
clean up documentation, and build it for the beta release, where we will try it
on a few live lessons to make sure this works for the community. It's a slow
process, but this way we can avoid major unforseen issues (minor issues are a
given), bring users in on the ground floor, get valuable feedback, and
strengthen trust with our community.

And I want to conclude by saying that we ended up choosing a solution that we
believe aligns with our values and will work with our community. We don't have
all the answers right now, but we go through this process because we want to
make sure we put people first and are always learning.

Thank you to our fiscal sponsor, Community Initiatives and generous grants from
the Alfred P. Sloan Foundation, the Moore Foundation, the Chan-Zuckerberg foundation,
and the R Consortium.
