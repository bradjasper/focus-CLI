<pre> ______
|  ____|
| |__ ___   ___ _   _ ___
|  __/ _ \ / __| | | / __|
| | | (_) | (__| |_| \__ \
|_|  \___/ \___|\__,_|___/

    Focus is a command line utility to steal back your focus.
</pre>

Focus is a small command line utility that blocks your favorite sites by adding local host names to your **/etc/hosts** file.

For example, if you need a break from the impulse of checking Gmail simply add **mail.google.com** to your **$HOME/.focus** file.

    echo "mail.google.com" >> ~/.focus

Then enter focus mode:

    > focus
    Focus is activated... go!

Now you're blocked from Gmail. Once you've accomplished some work and you want to switch back, simply unfocus:

    > unfocus
    Focus is deactivated...

Focus is easy to get started with and is careful about clobbering your /etc/hosts file.

# Install

    sudo pip install -e git+git@github.com:bradjasper/focus.git#egg=focus

Add some entries to **$HOME/.focus**

    > cat $HOME/.focus
    news.ycombinator.com
    reddit.com
    mail.google.com
    digg.com
    techmeme.com
    techcrunch.com

Jump in and out of focus mode:

    > focus
    ....
    > unfocus

# Contact
bjasper@gmail.com

Hello
