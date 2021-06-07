# Using R as a Community Workbench for The Carpentries Lesson Infrastructure

This will be the prose of the talk that I will use as the source for the
transcript. Assuming an average 140 words per minute, this should contain no
more than 420 words per section. 

## Introduction

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
ecosystem with pandoc is flexible enough to give us all the tools we need to 
reduce barriers for publishing lessons and furthers our mission. 

In this talk, I will introduce you to our current infrastructure, it's
challenges, our solution, and how we used past and present experiences from our
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

> In The Carpentries: you belong

Our values are what drive us and in The Carpentries, you belong, no matter if
you have been working as a systems administrator for a university HPC cluster or
if you have just learned to write your first python script.

> We are always learning

Last, but not least, I want to highlight that we are always learning. To do 
that, I want to you to look at this image of a small path worn into the grass
between two paved paths in a community greenspace. This is called a "cowpath" or
a "desire path" and it's a very important concept in design. While the original
designers of this greenspace intended for people to used the paved paths to get
from point A to point B, a large number of people have found that too 
inconvenient and opted for a quicker way where the hazard of uneven terrain
outweighs the extra time it takes to walk across this expanse.

Over the last few years, we have been thinking deeply not only about these paths
in our own infrastructure, but also where people are choosing to avoid it all
together because the process is just too difficult. 

## Infrastructure

Our lesson infrastructure is all open source and serves the purpose to provide
a way for people to write lessons openly with a consistent and predictable
style for both instructors and learners, and is transparent enough for people
to customize to their liking. As with any resource, be it a talk or a lesson,
it's important to know your audience. The audience for our lessons can be split
into four distinct groups whose skill sets are wide and varied.

1. The Carpentries instructor who uses it for reference material as they teach
   and contributes to lessons based on feedback from teaching
2. The learner in a workshop who uses the lesson as a reference later on
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
custom python scripts and a Makefile to orchestrate the build process
and validate that the style is consistent. This also demonstrates that the very
skills we teach in our workshops (BASH, Make, Git) have immediate application.

One of the drawbacks to this infrastructure design was that we had a lesson
wrapped around a static site generator, which meant that it was easy to
contribute to if you were familiar with how Jekyll operated, but if you were
unfamiliar, then it became unclear where to even start if you were looking at
the git repository because of all the exposed plumbing with no signs that
clearly say "start here". This aspect has lead to several lessons built in
_slightly_ different ways.

Remember the cowpaths I mentioned earlier? Over the last few years, we have
begun finding them from all across the lesson infrastructure popping up in
separate places that appear through issues and pull requests. Some maintainers
find it difficult to keep the software stack updated and end up spending more
time trying to understand errors that are coming from the Makefile, others will
see something that needs to be updated with the style and try to make changes
in the documentation repository, and still others find the process of using the
software so arduous that they would rather fork the repository to their own
github account, switch the branch for displaying changes, and use GitHub to
preview lessons. 

One of the biggest challenges were with our RMarkdown lessons. These are
rebuilt with the latest versions of R and R packages. When breaking changes
occurred, maintainers would only know when they were published on the website.
There was a big need for people to be able to preview content without deploying
it first.

So, now that we have our field full of cowpaths, we need to figure out which 
ones need to be paved over as we grow as an organisation and encounter more and
more chopportunities. 

## Chopportunities

By chopportunities, I am referring to a challenge that is also an opportunity. 
The growth that we've experienced in the past few years is a chopportunity.
In 2016, there were six lessons, but now we have over 45 official lessons in
two languages. The carpentries incubator has grown immensely over the last
year adding more than 30 new lessons in the last six months alone. 

Our challenge is clear: the all-in-one lesson infrastructure we have will not
scale well to the growing lessons under our umbrella, so we need to build 
infrastructure that scales even better.

Our opportunity here is to reimagine the infrastructure in a way that not only
scales well and is easily repairable, but also allows people from different
areas of expertise to contribute and share lessons, no matter their skill level,
language, or ability. Because, at the end of the day, our values drive our
mission. We have strength in diversity, we value all contributions, and we will
strive to put people first. 

Our new design needs to separate the content from the tools, and to use tools
that are supported by friendly communities where people don't have to feel
"techy" to feel like they belong. 

## Solution


### Challenge

We wanted a general solution where you could take markdown or RMarkdown files,
place them in a folder and generate a site without having complicated paths or
generated files lying around. The first thing we did was to look at prior art;
what has been built before. 

The natural place to go was blogdown, but we quickly realized that while the
tools were separated from the content, there were many aspects that would not
fit our model. It was then that I realized that {pkgdown}, a documentation site
generator, used the same model: It meets people where they are, content is pure
markdown with no extra templating required, the tools to build everything lived
in a separate package, and it can be customizable by making your own package
to host your CSS, JS, and HTML templates. 

From this example, we created a modular two-step solution that first renders 
source documents to markdown and then uses pandoc with a template engine to
render HTML. This two-step solution allows maintainers to easily see the diff of
the changes that happened from new code or updated packages _and_ because 
markdown is a common denominator for many static sites and document engines, the
output can be lifted from the repository and placed in the context of any other
engine. 

### Opportunity

Of course, our challenge ticks all the boxes that satisfy our design choices in
that it's modular,


## Conclusion

