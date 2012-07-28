What is this?
=============

This is what I am using to teach my child their letters. Meant to be used on a mobile device (mainly iPad) but should work on any resolution device.
You can see it in action here: <http://abcdees.herokuapp.com>. Developed with serve.

How do I install and run Serve?
-------------------------------

Serve is distributed as a Ruby gem to make it easy to get up and running. You
must have Ruby installed in order to download and use Serve. The Ruby download
page provides instructions for getting Ruby setup on different platforms:

<http://www.ruby-lang.org/en/downloads/>

After you have Ruby installed, open up the command prompt and type:

    gem install serve

(OSX and Unix users may need to prefix the command with `sudo`.)

After Serve is installed, you can start it up in a given directory like this:

    serve

This will start Serve on port 4000. You can now view the prototype in your
Web browser at this URL:

<http://localhost:4000>


Compass and Sass
----------------

This prototype uses Compass and Sass to generate CSS. Both are distributed as
Ruby gems and can be easily installed from the command prompt. Since the
Compass gem depends on Sass, you can install them both with one command:

    gem install compass

Learn more about Sass:

<http://sass-lang.org>

Learn more about Compass:

<http://compass-style.org>


Rack and Passenger
------------------

Astute users may notice that this project is also a simple Rack application.
This means that it is easy to deploy it on Passenger or in any other
Rack-friendly environment. Rack it up with the `rackup` command. For more
information about using Serve and Passenger see:

<http://bit.ly/serve-and-passenger>


Exporting
---------

To export this project to pure HTML and CSS you will need the prerelease
version of Serve. To get started with the prerelease version:

    gem install --pre serve

To export your project, use the new "export" command:

    serve export <project>:<output>

Where "project" is the path to the project and "output" is the path to the
directory where you would like your HTML and CSS generated.


Learning More
-------------

You can learn more about Serve on the GitHub project page:

<http://github.com/jlong/serve>

I really don't know anything about licenses but just in case I threw this on here:
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/80x15.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Abcdees</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/RyanS/abcdees" property="cc:attributionName" rel="cc:attributionURL">Ryan Szulczewski</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.
