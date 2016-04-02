# web-page-to-OSC-feature-extractor-chain
Example of a machine-learning feature-extractor that reads and parses a web page, publishes those results to text files and read/reformats those text file values into OSC packets.  These programs were written as a class project for Kadenze's 'Machine Learning for Musicians and Artists' class -- ably led by Rebecca Fiebrink.  

Purpose:

This is an example of how to convert parsed web page data into OSC packets.  XML is being parsed here, but there's no reason the web page has to be pushing XML, this generalizes to any HTML page.  I'm using REBOL because that's what I'm most comfortable with for this kind of parsing.  The architecture (an intermediate stop in text files) is stupid -- but I couldn't find a programming environment that was good at parsing AND good at creating OSC packets.  Max/MSP just might be able to do it all, but the parsing just killed me.  

Look in the comments of the programs for tips.

This repository contains:

- An overview graphic of the larger machine-learning chain that shows where these feature-extraction programs fit   file name:
- A graphic that just shows the two programs and the files they share - file name:  
- Source code for a REBOL (www.rebol.com) program that strobes the eGauge for XML and parses the XML and writes a series of text files with the result - file name: egaugeReaderV3.r
- Source code for a ChucK (chuck.cs.princeton.edu) program that in turn strobes the text files and converts the values to OSC messages that can then be passed along to any program that groks OSC (in our class, this would be Rebecca Fiebrink's nifty Wekinator machine learning program - www.wekinator.org)  file name: PowerReadr.ck
