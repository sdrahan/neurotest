# neurotest

See in action: http://sergeydragan.com/neurotest/

Task 1: made a simple game using LinearRotator component.

Pass the instance of ILinearRotatorLayout to the LinearRotator constructor to set layout type and scroll direction. Create your own instances to customize it.

LinearRotator.pushItemDataVO() is the only method you need to use.

RotatorItemRenderer: you can override init(), getSize(), fadeIn(), fadeOut(), highlight() and unhighlight() methods.

Optional parameter "customState" can be passed to unhighlight() method, so ItemRenderer will show custom behaviour (i.e. "correct"/"wrong" in demo).


Task 2: implemented two popular sorting methods and compared their performance;

Task 3: resulting value is the current time minus one day; the trick was in "int" - not suitable to hold the time

Task 4: very basic - but working - algorithm

    1. Create a full-screen grid of rectangular cells;
    2. Start from a random cell, and then move randomly chosen direction one adjacent cell per step;
    2.1. In case if we've got ourselves into the corner, and there are no possible steps available - jump to random not adjacent cell;
    3. Make amount of steps equal to the amount of dots;
    4. Display a dot at the cells repeating our "steps" route.

Task 5: implemented simple GridPattern class using mix of normal and 9sliced images, and would be happy to discuss possible ways to optimize it. Initially we are creating 50 elements and then randomly change their position each frame.
Press Up / Down to add or remove 50 elements.