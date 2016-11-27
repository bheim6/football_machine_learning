---
layout: post
title:  "Neural Net Basics and Forward Propagation"
date:   2016-11-23 14:11:30
author: "Brian Heim"
---
## What is a Neural Net?

A Neural Net at its most basic level is a machine learning algorithm that uses a series of "decision-making" nodes to predict an outcome.

* When researching we found this literature to be very helpful and would encourage anyone who is interested in building a neural net to check it out: [link to Neural Net and Deep Learning book](http://neuralnetworksanddeeplearning.com/about.html)

## Basic Architecture

All Neural Nets must have at least two layers, an input layer (where data is introduced to the net, either training data, or data used in making a prediction), and an output layer (result of the input layer data moving through the net). However, most neural nets contain one or more hidden layers of decision making nodes as well. In the case of our neural net, we included one hidden layer.

* Since the players in our database all have twelve possible statistical categories, we knew we would need at least twelve input nodes, one for each value. In order to make predictions based on the previous four game stats for a player, we had to multiply the number of input nodes by four, giving us a total of forty-eight input nodes.
* The output layer remains twelve nodes, one for each stat category, since we only want to predict one "week" of data. The hidden layer size was determined less mathematically than the others.
* It was suggested based on our research to choose a number roughly halfway between the input and output layers, so we chose a node count of thirty. This hidden layer works behind the scenes and is the "magic" of the neural net. Fortunately, the specific node count in this layer is arbitrary in a sense, provided that the node count is within a reasonable range.

* This provided us with a neural net with the shape of [48 x 30 x 12]. Below is an image of a [3 x 4 x 1] neural net:

![Architecture](http://neuralnetworksanddeeplearning.com/images/tikz1.png)

### Input Layer

The values in this layer are essentially a likelihood of something occurring, so any input value must be between a 0 and 100% likelihood.

#### Data Normalization

Since inputs are a probability, they need to be normalized based on some criteria. In the case of our net, we looked up the current NFL record in each category, and determined our 100% max value by padding each record with some extra values in an attempt to make the ceiling be just out of reach of what seems possible to achieve.

We then compare the input value with our maximum calculated value and zero, to grant a percentage. For example, if the max passing yards was determined to be 800 yards, and a player throws for 400 yards, their normalized passing yards would be input to the net as 800 / 400 = 0.5.

### Hidden Layer

The hidden layer has an inherent uncertainty.

### Output Layer

## Assigning Weights and Biases

Will explain importance of weights and biases, but will make sure to highlight that the magic of NN is that these will morph based on f and b prop, so the initial values just need to be random

### Sigmoid

and will then go over our choice for sigmoid.

## Forward Propagation

Will then go over the basic idea of forward prop, sending data into input node, how values move from each layer via multiplying by weights and biases to achieve a value in the output layer.
