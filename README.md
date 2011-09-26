Chatreach
=======

An open source tool built in Ruby on Rails for social service agencies to provide text message based content and locator services for their clients.

[![Chatreach](https://github.com/danmelton/chatreach/raw/master/public/images/chat_reach_logo_white_clean.png)](http://chatreachwiki.pbworks.com)


Getting Started Guide
-------------

http://chatreachwiki.pbworks.com/

Development Installation
------------

We recommend using Ruby Version Manager.

    git clone git@github.com:danmelton/chatreach.git
    cd chatreach
    bundle install
    rake db:migrate

To get Seed Data:

    rake db:reset
    or
    rake db:seed

Status
-------

This application is going through a heavy re-write. You can see progress here [roadmap](http://github.com/danmelton/chatreach/issues)


Credits
-------

This application was built with the support of Advocates for Youth and New Morning Foundation in 2008.  The code is offered as BSD

Contributing
------------
In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues](http://github.com/danmelton/chatreach/issues)
* by reviewing patches

Submitting an Issue
-------------------
We use the [GitHub issue tracker](http://github.com/danmelton/chatreach/issues) to track bugs and
features. Before submitting a bug report or feature request, check to make sure it hasn't already
been submitted. You can indicate support for an existing issuse by voting it up. When submitting a
bug report, please include a [Gist](http://gist.github.com/) that includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem version, Ruby version, and
operating system. Ideally, a bug report should include a pull request with failing specs.

Submitting a Pull Request
-------------------------
1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run <tt>bundle exec rake doc:yard</tt>. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run <tt>bundle exec rake spec</tt>. If your changes are not 100% covered, go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec, version, or history file. (If you want to create your own version for some reason, please do so in a separate commit.)
