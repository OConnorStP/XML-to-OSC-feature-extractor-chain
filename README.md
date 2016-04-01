# XML-to-OSC-feature-extractor-chain
Example of a machine-learning feature-extractor that parses XML, publishes those results to text files and read/reformats those text file values into OSC packets.  These programs were written as a class project for Kadenze's 'Machine Learning for Musicians and Artists' class -- ably led by Rebecca Fiebrink.  

Purpose:

This is an example of how to convert parsed web page data into OSC packets.  XML is being parsed here, but there's no reason the web page has to be pushing XML, this generalizes to anything that can be parsed.  I'm using REBOL because that's what I'm most comfortable with for this kind of parsing.  The architecture (an intermediate stop in text files) is stupid -- but I couldn't find a programming environment that was good at parsing AND good at creating OSC packets.  Max/MSP just might be able to do it all, but the parsing just killed me.  This may still serve as a good example even if you use different environments to do the steps.

Look in the comments of the programs for tips.

This repository contains:

- An overview graphic of the larger machine-learning chain that shows where these feature-extraction programs fit   file name:
- An example of a system that you might want to extract features from (in this case, this is a screen-shot of an eGauge power-monitoring system that can produce a realtime XML snapshot of the states of various power meters)  file name:
- An example of the XML that is produced by that system (this is useful in understanding how the first program is doing the parsing)  file name:  
- Source code for a REBOL (www.rebol.com) program that strobes the eGauge for XML and parses the XML and writes a series of text files with the result   file name:
- Source code for a ChucK (chuck.cs.princeton.edu) program that in turn strobes the text files and converts the values to OSC messages that can then be passed along to any program that groks OSC (in our class, this would be Rebecca Fiebrink's nifty Wekinator machine learning program - www.wekinator.org)  file name:
