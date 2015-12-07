# neurotest

See in action: sergeydragan.com/neurotest/

Task 1: made a simple game using LinearRotator component.

Pass the instance of ILinearRotatorLayout to the LinearRotator constructor to set layout type and scroll direction. Create your own instances to customize it.

LinearRotator.pushItemDataVO() is the only method you need to use.

RotatorItemRenderer: you can override init(), getSize(), fadeIn(), fadeOut(), highlight() and unhighlight() methods.

Optional parameter "customState" can be passed to unhighlight(), so ItemRenderer will show custom behaviour (i.e. "correct"/"wrong" in demo).


Task 2: implemented two popular sorting methods and compared their performance;

Task 3: resulting value is the current time minus one day; the trick was in "int" - not suitable to hold the time

Task 4:

    Make dots not overlap with each other:
    1. Build a grid with a cell size depending on dots amount (more dots - less the size of cells);
    2. Put dots in randomly selected cells with some random distance from its center (distance < cell.size/2);

    Connect dots "not too randomly":
    3. Start with a dot closest to the border;
    4. Use line intersection algorithm to interact through every other free dots to search for a shortest possible non-intersecting path;
    5. If there's no path available - choose any free dot and draw a line to it.

Task 5: implemented simple GridPattern class using mix of normal and 9sliced images, and would be happy to discuss possible ways to optimize it. Initially we are creating 100 elements and then randomly change their position each frame.
Press Up / Down to add or remove 50 elements.