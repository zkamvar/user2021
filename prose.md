# Using R as a Community Workbench for The Carpentries Lesson Infrastructure

The Carpentries is a global organization of volunteers who teach
foundational data and coding skills to researchers worldwide. What makes us
stand out is not the fact that we use evidence-based practices in teaching, it's
that we align all of our decisions with our core values: we put people first
and we value all contributions.

Our lessons are distributed as open-licensed websites built on a consistent
style that adheres to active learning principals. We use these lessons as the
source material for the hundreds of workshops we run each year. So, these sites
have three distinct audiences:

1. First, the certified Carpentries Instructors who refer to these materials as
   they teach our workshops.
2. Next, there are he learners in a Carpentries workshop who rely on these
   lessons after a workshop as they review and practice their newly aquired
   skills.
3. Last, but not least, there are the educators like yourselves, who adapt
   these open-licensed materials for their own lessons.

The source for these lessons are hosted on GitHub where volunteer Maintainers
ensure that the lessons are accurate and up-to-date. 

We encourage a culture of open contribution, where members of our community can
suggest improvements like a simple typo fix or a better explanation of an
important lesson concept.

We want **anyone** to be able to go to the repository and make a suggestion to
improve our lessons... 

at least that was our intention.

I want to pause for a second here and highlight this tweet that came across my
feed as I was preparing this talk.

It shows a fork between a paved path and an unpaved footpath across a patch of
grass, which leads to a crosswalk. There is a sign in front of the unpaved path
that says "Please use the purpose made path provided." The tweet author points
out that "the sign knows it has lost."

This unofficial footpath is called a "desire path". It is an
important concept in design because it shows the difference between what
the designers intended and how people actually use the space.

As our community has grown, new desire paths were being created across our
lesson infrastructure landscape. No signs or, in our case, documentation would
stop contributors to our lessons from stepping outside these complex, purpose
made, paths in our lesson infrastructure. 

We needed to rethink our infrastructure altogether in a way that is more
inclusive and welcoming for everyone.

We found that the R publishing ecosystem is flexible enough to give
us the tools we need **to reduce barriers for publishing lessons and
further our mission**. 

I will introduce you to our current infrastructure, its unique challenges, our
solutions, and how we used past and present feedback from our community to
iteratively refine our design.

Before continuing, I want to remind everyone of two things. First:

> There is no right or wrong, only better or worse.
>
> --- GW

Greg Wilson---the founder of Software Carpentry---wrote this after several
iterations of the lesson infrastructure. I am putting it here as a reminder that
the infrastructure we have now was working for us at the time. What we come up
with will have its own difficulties down the road, but what is important is that
we build something that better addresses the needs of our community, which leads
me to my second reminder:

> You belong in The Carpentries

As the community has grown, our infrastructure has been put to the test and we
have continuously updated our workflows to make it easier for people to
contribute.  The reason we do this is because we are driven by our values. 

In The Carpentries, you belong, no matter if you have been working as a systems
administrator for a university HPC cluster or if you have just learned to write
your first R script.

To better understand the decisions we are making, let's start by reviewing
our current infrastructure.

## Infrastructure

Our lessons are written in markdown and transformed into a website via GitHub
Pages and the Jekyll static site generator.

The idea behind this choice was that it was the most straightforward way to
create a static website without needing a server like Wordpress or Drupal sites.
Ideally, it also provided a way for people to use this as an example of how they
could build their own website.

The paradigm of being able to write markdown lessons and get a functional website
out of it is not a new concept. In fact, there are over 460 iterations of
this concept (according to https://staticsitegenerators.net). Jekyll happens to
be the one that GitHub implemented early on to provide documentation for the
open-source project it hosted, and thus, it stuck.

We created an all-in-one bundle for lessons that provided styling templates in
HTML, CSS, and JavaScript along with validation scripts in Python, and R scripts
to build RMarkdown-based lessons. All of this was orchestrated by a Makefile.
The purpose of this approach was two-fold:

1. To maintain a consistent style that emphasized our principles of
   evidence-based teaching such as learning objectives and formative assessment;
2. To demonstrate how the skills we teach in our workshops could be applied
   to real-life situations.

While this was conceptually good in theory, this infrastructure design has three
significant drawbacks for contributors:

The first is installation pains.

Having Jekyll, Python, and Make as dependencies means that people who want to
build these lessons on their machines need all three of these successfully
installed and up-to-date. This is especially frustrating for Windows users who
have none of these by default.

Secondly, with this design, all the scripts live _inside_ the repository.

This leads to the unfortunate pattern where lessons quickly become out of date
as they diverge from the improvements made upstream.

Another drawback is that we have a lesson website wrapped around a static site
generator (which in and of itself is a kind of desire path), this meant that it
was easy to contribute _if you were familiar with how Jekyll operated._ 

There is often a moment of panic in a new contributor's eyes when you show them
what the a lesson repository looks like. If you were not familiar with Jekyll,
then it was unclear where to even start if you were looking at the git
repository because there were no clear sign that marked the trail head. This
lead several lessons to find their own paths that ended up built in different
ways.

Over the last few years, we have begun finding these desire paths all across our
lesson infrastructure. These manifested through our communication channels and
frustration from contributors and maintainers alike. 

The thing about desire paths, though, is that they are not only challenges, but
also opportunities.

## Chopportunities

At The Carpentries, we like to call these "chopportunities."

![bar chart showing the growth of the number of carpentries lessons per quarter.
There are currently over 140 lessons](lesson-growth.png)

The growth that we have experienced in the past few years is a chopportunity.
We have seen not only a growth in the number of community members, but also,
in the number community contributed lessons since we started
The Carpentries Incubator.

Our challenge is clear: the all-in-one lesson infrastructure does not scale
well to the growing number of lessons.

Our opportunity here is to re-imagine the infrastructure in a way that truly
values all contributions: this includes the spectrum from everyday educators
who want to share their knowledge, to the tinkerers who want access panels to
understand what is going on behind the scenes.

## Solution

The solution we came up with uses R and I simply do not have enough time to
discuss all the features, but you can find out for yourself if you visit our
blog posts and documentation on how to get started.

So, how and why did we choose R to create the next iteration of our lesson
infrastructure?

### Challenge

We wanted a general solution where you could take markdown or RMarkdown files,
place them in a folder and generate a Carpentries-style lesson without having
complicated paths or generated files lying around. The first thing we did was
to investigate the existing landscape.

It was important that we choose something that is user friendly, easy to
install, easily customizable, and has a welcoming community behind it. We tried
out several static site generators, but the largest barrier for many of these
was that they were not easy to install and maintain.

We settled on the fact that R is the best place to go for our needs
because:

1. First and foremost: R is chock-full of friendly communities!
  - RLadies
  - ROpenSci
  - RForwards
  - MiR
2. R is easy to install on all major operating systems and
   is available online via RStudio Cloud
3. R has a robust ecosystem for publishing thanks to {knitr} and RMarkdown

Once we identified R as our solution, the natural place to go was one of the
RMarkdown variants like {blogdown} or {hugodown}, but we found that while the
tools were indeed separated from the content and the documentation was rich and
accessible, there were many aspects that would not fit our needs, in particular
the presence of styling inside the repository, meaning that the user was 
ultimately responsible for maintaining the visual presence.

We realized that an unlikely contender, {pkgdown}, a documentation site
generator, used the same model that we were looking for: It meets people where
they are, content is pure markdown with no extra templating required, the tools
to build everything lived in a separate package, and you can customize its
appearance by making your own package to supply your CSS, JavaScript, and HTML
templates, which has been done many times for individual and organization-wide
documentation. 

From this model, we were able to pave over the desire paths in our
infrastructure by creating three R packages: 

 - {sandpaper} is the engine that orchestrates building and maintaining lessons
 - {varnish} is the styling that hosts the CSS, JavaScript, and HTML templates
 - {pegboard} serves as a validator (and converter!) for lesson content

Of course, the first thing any contributor will see is the folder structure and
it will help if this resembles the structure of the lesson website.

So our lessons consist of folders that correspond to the website dropdown menus:
one folder for lesson chapters, one for extra information for learners, one for
extra information for instructors, and one to contain learner profiles.

The final folder is one of the access panels that contains the rendered
markdown files---so you can use them in another context---and static
website---so that you can put it on a USB stick to share it without additional
software (like Hugo or Jekyll).

### Opportunity

Our solution ticks all the boxes that satisfy our design choices,
but if we ended up designing something that R enthusiasts
love, but is unusable by newcomers, Python, or Matlab folks, then we are not
in line with our value of being inclusive of all.

Our goal is for authors to focus on the content over the tooling.
We want lesson authors to create a lesson directly from the source
they already work with: markdown/RMarkdown/MyST notebooks.
To do this, we needed to test the minimal
viable product on actual maintainers and we needed to make sure that they were
spread across the spectrum of familiarity with:

 - using R,
 - the current infrastructure,
 - the way The Carpentries operates.

We recruited a total of 19 volunteers to run through Alpha Testing, which tested
the participants ability to install the required software and packages, create,
modify, and contribute to lessons. After the tests, I asked for 20-minute
open-ended interviews from the volunteers about their experience to identify
common stumbling blocks, challenges, and bright points. 

I want to take a moment to thank everyone who has participated, some of whom are
part of The Carpentries core team. I don't have the time to go into detail about
the results, but a big takeaway from this was that everyone was able to install
the infrastructure and any problems that occurred were from Git/GitHub, which is
a big improvement over the current system.

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

We have just finished with this first testing phase and the next step for us is
to address the questions and concerns that were brought up (for example: how do
I use this without clobbering the current R installation on my system?), improve
the documentation, and get ready for the beta release, where we will try it on a
few live lessons to identify painpoints for the community. It is a slow process,
but this way we can avoid major unforseen issues (minor issues are a given),
bring users in on the ground floor, get valuable feedback, and strengthen trust
with our community.

> if you want to go fast, go alone; if you want to go far, go together

And I want to conclude by saying that we ended up choosing a solution that we
believe aligns with our values and will work with our community. We do not have
all the answers right now, but we go through this process because we want to
make sure we put people first and are always learning.

None of this would have been possible without generous grants from the Alfred
P. Sloan Foundation, the Moore Foundation, the Chan-Zuckerberg Initiative, and
the R Consortium Infrastructure Steering Committee.

And finally, thank you to all of our alpha testers, the carpentries community,
and all the folks who have taken the time to sit down and talk with me about
early drafts of the new infrastructure.

And thank you for listening.
