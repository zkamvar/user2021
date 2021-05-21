The Carpentries is a global community of volunteers that collaboratively
develops and delivers lessons to build capacity in data and coding skills (in R
and multiple other languages) to researchers worldwide. For the past five
years, our collaboratively-developed lesson template
(https://github.com/carpentries/styles/) has been the basis for our growing
collection of peer-reviewed lesson content. This template was fully
self-contained with all the tools and styles needed to create a full lesson
website. While the lessons themselves were designed to be easy to author, there
were two significant barriers in our toolchain for contributors: software
installation and style updating. As our lesson repertoire and community has
continued to grow, this template model has not scaled well, resulting in
barriers to entry and wasted volunteer time. In 2020 we began the process to
redesign our template from the ground up using a combination of R’s literate
programming ecosystem and GitHub Workflows, resulting in three R packages
called [{sandpaper}], [{pegboard}], and [{varnish}] for handling, validating,
and styling lessons. The new approach separates the content from the tools and
style, allowing for seamless updates so the maintainers can focus on authoring
their lessons and not on the tools needed to build them. To accommodate the
wide array of diverse skill sets in our community, we wanted to ensure the
tools could be used by anyone without any prior knowledge of R. We will detail
how we involved our community in iterated development of the new template with
user stories, passive community feedback, community member interviews, and user
experience testing. In the end, we will show how the wide array of tools
available in the R ecosystem makes it easy for us to rebuild our lesson
infrastructure in a way that significantly reduces the barrier for entry for
our community volunteers.

[{sandpaper}]: https://carpentries.github.io/sandpaper
[{pegboard}]: https://carpentries.github.io/pegboard
[{varnish}]: https://github.com/carpentries/varnish
