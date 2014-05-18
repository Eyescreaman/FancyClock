FancyClock
==========

The simple sample to show that how to do the fancy clock. 

0.The core is MyFancyClockView with in the ClockView folder.

1.How to use ?

Create the MyFancyClockView like :

[[MyFancyClockView alloc] initWithFrame:CGRectMake(x,y,width,height)];

Set up the 12 images for 12 hours like:

[mFancyClockView initWithImageNameArray:imagearray];

Start the Clock Animation like:

[mFancyClockView startClockAnimation];
