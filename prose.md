# Using R as a Community Workbench for The Carpentries Lesson Infrastructure

This will be the prose of the talk that I will use as the source for the
transcript. Assuming an average 140 words per minute, this should contain no
more than 420 words per section. 

> word count: ~2400 words; 160 wpm
> timing 2021-06-09: 14:48.61 :grimace:

## Introduction

> timing 2021-06-09: 03:37.11

The Carpentries is a global organization of volunteers who strive to teach 
foundational data and coding skills to researchers worldwide. What makes us
stand out is not the fact that we use evidence-based practices in teaching, it's
that we align all of our decisions with our core values which puts people first
and accepts all contributions. 

Our lesson infrastructure was built on the principles of our values to act 
openly, but as the expertise of our contributors broadens and the number of
lessons grow, we are finding ways that our infrastructure was not quite meeting
our values that accepts all contributions and puts people first.

In reimagining an update to our lesson template, we found that the R publishing
ecosystem with pandoc is flexible enough to give us all the tools we need **to 
reduce barriers for publishing lessons and furthers our mission**.

In this talk, I will introduce you to our current infrastructure, it's
challenges, our solutions, and how we used past and present experiences from our
community to iteratively refine our design. 

And before I move on, I want to remind everyone of three things:

> There is no right or wrong, only better or worse 
> 
> --- GW

This quote by Greg Wilson was written after several iterations of the lesson
infrastructure and I put it here as a reminder that the infrastructure we have
right now was working for us at the time and what we come up with will have its
own difficulties down the road, but what is important is that we build something
that better addresses the needs of the community, which leads me to my second
reminder:

> We are always learning

<https://twitter.com/SarahNicholas/status/1401510907604353024?s=20>

The above tweet came across my feed as I was preparing this talk and it was very
timely. It shows a fork between a paved path and an unpaved footpath across a
patch of grass, which leads to a crosswalk. This is called a "cowpath" or a
"desire path" and it's a very important concept in design. While the original
designers of this greenspace intended for people to use the paved paths to get
from point A to point B, a large number of people have found that too
inconvenient and opted for a quicker way where the hazard of uneven terrain
outweighs the extra time it takes to walk across the two legs of the triangle. 

Of course, the focal point of this tweet is the sign that is planted in front of
the cowpath, which says "Please use the purpose made path provided." The author
is correct in claiming that the sign knows it has lost because people have 
simply steped to the side of the sign. 

Over the last few years, we have been thinking deeply not only about these paths
in our own infrastructure, but also where people are choosing to avoid it all
together because the process is just too difficult. Instead of putting up signs
that tell people where they should go, we are using these paths to learn how new
members of our community want to use this infrastructure, which brings me to
my last point.

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

Our lesson infrastructure is all open source and serves the purpose to provide
a way for people to write lessons openly with a consistent and predictable
style for both instructors and learners, and is transparent enough for people
to customize to their liking. As with any resource, be it a talk or a lesson,
it's important to know your audience. The audience for our lessons can be split
into four distinct groups whose skill sets are wide and varied.

1. The Carpentries instructor who uses it for reference material as they teach
   and contributes to lessons based on feedback from teaching.
2. The learner in a workshop who uses the lesson as a reference later on. 
3. The maintainer, who makes sure the information on the lesson is accurate and
   up to date.
4. The educator who wants to use these open-licensed materials for their own
   lessons.

Our lessons are written in markdown and translated to HTML via GitHub pages and
the Jekyll static site generator. We encourage and accept all 
contributions---anyone can contribute to these lessons on GitHub by opening an
issue or creating a pull request and editing the markdown source files.

To maintain a consistent style and encourage our princples of evidence-based 
teaching such as learning objectives and formative assessments, our
infrastrcutre is an all-in-one bundle that contains a Jekyll theme with
custom python scripts, R scripts for Rmarkdown-based lessons, and a Makefile to
orchestrate the build process and validate that the style is consistent. This
also demonstrates that the very skills we teach in our workshops (BASH, Make,
Git) have immediate application.

It's important to pause here and point out that the entire paradigm for this is
for people to be able to write markdown lessons and get a functional website
out of it. This is not a new concept, in fact, there are over 460 iterations of
this concept according to https://staticsitegenerators.net. Jekyll happens to
be the one that was used by GitHub early on and thus it stuck. 

This infrastructure design has two significant drawbacks: 

1. Installation pains. Having Jekyll, Python, and Make as dependencies means
   that people who want to build these lessons need all three of these
   successfully installed and up-to-date on their machines. This is especially
   frustrating for Windows users who have none of these by default. Moreover,
   having all the tools living inside the repository meant that updating the
   repository required pull requests that were unrelated to the lesson itself. 
2. Another drawback is that we have a lesson website wrapped around a static
   site generator, which meant that it was easy to contribute to if you were
   familiar with how Jekyll operated. Some would say Jekyll is well documented,
   but in my experience, Jekyll is well, documented. There is often a moment of
   panic in a new contributor's eyes when you show them what the a lesson
   repository looks like. If you were not familiar with Jekyll, then it was
   unclear where to even start if you were looking at the git repository because
   of all the exposed wiring with no signs that clearly say "start here". This
   aspect has lead to several lessons built in _slightly_ different ways.

This brings me back to the cowpaths. Over the last few years, we have
begun finding them from all across the lesson infrastructure popping up in
separate places that appear through issues and pull requests. Some maintainers
find it difficult to keep the software stack updated and end up spending more
time trying to understand errors that are coming from make, python, or Jekyll,
others will try to make changes in the "do not touch" areas of the repository,
and still others find the process of using the software so arduous that they
would rather fork the repository to their own github account, switch the branch
for displaying changes, and use GitHub to preview lessons.

Moreover, our R-based lessons used RMarkdown to automatically generate the 
output. One common pattern we find is that people will invariably contribute to
the generated file, which means that all of their changes will be erased when
the lesson rebuilds. 

So, now that we have our field full of cowpaths, we need to figure out which 
ones need to be paved over as we grow as an organisation and encounter more and
more chopportunities. 

## Chopportunities

> timing 2021-06-09: 01:15.30

By chopportunities, I am referring to a challenge that is also an opportunity. 
The growth that we've experienced in the past few years is a chopportunity.
In 2016, there were six lessons, but now we have over 45 official lessons in
two languages. The carpentries incubator has grown immensely over the last
year adding more than 30 new lessons in the last six months alone. 

Our challenge is clear: the all-in-one lesson infrastructure does not scale
well to the growing number of lessons under our umbrella, so we need to build
infrastructure that scales even better and separates the tools from the content.

Our opportunity here is to reimagine the infrastructure in a way that truly 
values all contributions: this includes the spectrum from everyday educators
who do not feel "techy" to the tinkerers who like to peek under the hood. To do
this, we need to think back to the unifying purpose of having the lesson
infrastructure in the first place: to empower authors to write lessons in
a markdown variant, and host them on a website. This means that our solution
must not only include direct on-ramps for everyone, but also build in access
panels for people who want to understand the engine driving everything.

## Solution

> timing 2021-06-09: 04:47.01

### Challenge

We wanted a general solution where you could take markdown or RMarkdown files,
place them in a folder and generate a site without having complicated paths or
generated files lying around. The first thing we did was to look at prior art,
or, what has been built before.

It was important that we choose something that was user friendly, easy to 
install, easily customizable, and had a welcoming community behind it. We tried
out several static site generators, but very few were easy to install and none
of them fit all of our criteria.

Eventually, we settled on the fact that R is the best place to go for our needs
because of several reasons, but mostly:

1. First and foremost: R is full of friendly communities! 
2. R comes as a binary that can be installed on all major operating systems and
   is available online via RStudio Cloud
3. R has a robust ecosystem for publishing thanks to {knitr} and RMarkdown

Once we identified R as our solution, the natural place to go was blogdown, but
we quickly realized that while the tools were separated from the content and the
documentation was rich and accessible, there were many aspects that would not
fit our model including the presence of styling within the repository. 

We realized that an unlikely contender, {pkgdown}, a documentation site
generator, used the same model that we were looking for: It meets people where
they are, content is pure markdown with no extra templating required, the tools
to build everything lived in a separate package, and it can be customizable by
making your own package to host your CSS, JS, and HTML templates. 

From this model, we created three packages to serve as the infrastructure tools,
styling, and validation:

 - {sandpaper} to orchestrate building and maintaining lessons
 - {varnish} to host the CSS, JS, and HTML templates
 - {pegboard} to serve as a validator (and converter!) for lesson content 

When thinking about the lesson structure itself, we thought about what would
make sense for a maintainer or contributor to contribute to a lesson would be
a folder structure that is reflected in the website dropdown menus, so our
lessons consist of folders that we use commonly: one folder for lesson
chapters, one for extra information for learners, one for extra information for
instructors, and one to contain learner profiles. The final folder contains the
rendered markdown files so you can use them in another context and website so
that you can put it on a USB stick and share it without needing to run a local
server. 

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
spread across the spectrum of using R, familiarity with the current 
infrastructure, and even familiarity with The Carpentries.

We recruited a total of 18 volunteers to run through the Alpha Test, which tested
the participants ability to install the infrastructure, create a lesson, modify
a lesson, and contribute to an existing lesson. After the tests, we asked for
20 minute open-ended interviews about their experience with the new tempalte to
see what features people kept stumbling over.

> Thank alpha testers here in slide

## Conclusion

> timing 2021-06-09: 00:48.79

We have just barely finished with the alpha testing and the next phase for us is
to address all the issues that were brought up, clean up documentation, and 
build it for the beta release, where we will try it on a few live lessons to
make sure this works for the community. It's a slow process, but this way we
can avoid major unforseen issues (minor issues are a given), bring users in on
the ground floor, get valuable feedback, and strengthen trust with our
community.

And I want to conclude by saying that we ended up choosing a solution that we
believe aligns with our values and will work with our community. We don't have
all the answers right now, but we go through this process because we want to
make sure we put people first and are always learning.

Thank you to our fiscal sponsor, Community Initiatives and generous grants from
the Moore Foundation and the Chan-Zuckerberg foundation.
