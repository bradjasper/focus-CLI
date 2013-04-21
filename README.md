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
    Focusing...go be productive!

Now you're blocked from Gmail. Once you've accomplished some work and you want to switch back, simply unfocus:

    > unfocus
    Unfocusing..were you productive?

Focus is easy to get started with and is careful about clobbering your /etc/hosts file.

# Install

Download the 3 scripts and make sure focus/unfocus are somewhere on your path.

**Warning:** I recommend backing up your **/etc/hosts** file first. Focus is careful (and backs up to /etc/hosts.bak automatically), but better safe than sorry.

Add some entries to **$HOME/.focus**

    > cat $HOME/.focus
    news.ycombinator.com
    reddit.com
    mail.google.com
    digg.com
    techmeme.com
    techcrunch.com
    mixpanel.com
    twitter.com
    api.twitter.com
        
Jump in and out of focus mode:

    > focus
    > ping mail.google.com
    PING mail.google.com (127.0.0.1): 56 data bytes
    ....

    > unfocus
    > ping mail.google.com
    PING mail.google.com (209.85.225.19): 56 data bytes
    ..

# Focusing without a sudo password

Focus modifies your /etc/hosts file which requires a sudo password. If you want to get around entering this for every command, type `sudo visudo` and add the following line:

    brad    ALL=(ALL) NOPASSWD: /Users/brad/Projects/focus/focus.sh                         

Replaces brad with your username (`whoami` will help here) and `/Users/brad/Projects/focus/focus.sh` to the path of your `focus.sh` file.

You should now be able to use focus without entering your sudo password!

**Warning:** Be careful here. Using visudo is an advanced topic and if you don't know what you're doing you might mess up your system.


# Contact
@bradjasper
