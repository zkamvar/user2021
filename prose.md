# Using R as a Community Workbench for The Carpentries Lesson Infrastructure

This will be the prose of the talk that I will use as the source for the
transcript. Assuming an average 140 words per minute, this should contain no
more than 140 words per section. 

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

Last, but not least, we are always learning. This entire talk is an ode to
always learning as we explore how we decided to start again with our lesson 
infrastructure. 

## Infrastructure

Our lesson infrastructure is all open source and serves the purpose to provide
a way for people to write lessons openly in a way that provides a consistent and
predictable style for both instructors and learners, and is transparent enough
for people to customize to their liking. As I mentioned before, there have been
several iterations of the lesson infrastructure, but the one we have right now
is an all-in-one starter pack that uses kramdown-flavored markdown built on top
of a Jekyll theme which also contains custom python scripts and a Makefile,
which not only orchestrate the building and validation process (for those who
don't remember Jekyll commands), but also demonstrates the very skills we teach
in our workshops. It's a bit like industrial architectural design with exposed
plumbing. 

It's extremely worth mentioning that our template has four different audiences:

1. The Carpentries instructor who uses it for reference material as they teach
2. The learner in a workshop who uses the lesson as a reference later on
3. The maintainer, who makes sure the information on the lesson is accurate and
   up to date.
4. The educator who wants to use these open-licensed materials for their own
   lessons. 

The skill sets across and within these communities is wide and varied. 

Our maintainer community is a special community because they not only need to 
know how to collaborate on GitHub, but they also need domain knowledge in the
lesson they maintain to be able to accurately evaluate new contributions. 

## Chopportunities

## Solution

## Conclusion

