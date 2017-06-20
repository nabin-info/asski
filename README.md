# asski
asski contains various techniques toward remapping ASCII charset to various 
targets.  It also provides some nice scripts for working with unicode in 
general.

As a side-effect, you can learn unicode experimenting with this repo

# Examples
**NOTE: the output is far from stable, expect things to change**

    $ unicodedata.bash | grep -i -e cat\ face
    INFO: using unicode data file: /home/rnabinger/.unicode.data
    U+1F431         🐱       CAT FACE
    U+1F638         😸       GRINNING CAT FACE WITH SMILING EYES
    U+1F639         😹       CAT FACE WITH TEARS OF JOY
    U+1F63A         😺       SMILING CAT FACE WITH OPEN MOUTH
    U+1F63B         😻       SMILING CAT FACE WITH HEART-SHAPED EYES
    U+1F63C         😼       CAT FACE WITH WRY SMILE
    U+1F63D         😽       KISSING CAT FACE WITH CLOSED EYES
    U+1F63E         😾       POUTING CAT FACE
    U+1F63F         😿       CRYING CAT FACE
    U+1F640         🙀       WEARY CAT FACE




    $ OFS='   ' utf8table.bash U+1F430:0x1f440:1
    
    U+1F430 to U+1F440 every U+1
    128048 to 128064 every      1
    🐰   🐱   🐲   🐳   🐴   🐵   🐶   🐷   🐸   🐹   🐺   🐻   🐼   🐽   🐾   🐿



I wanna thank some great places that made this all possible:

* [unicode.org](http://unicode.org/versions/Unicode9.0.0/)
* [wikipedia.org](https://en.wikipedia.org/wiki/Plane_(Unicode))
    
Please make pull requests and lets keep it funky.



