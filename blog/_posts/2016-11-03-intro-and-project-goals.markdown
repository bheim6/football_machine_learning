---
layout: post
title:  "Intro & Project Goals"
date:   2016-11-03 19:20:30
author: "Jean Joeris"
---
## Introduction

As students at Turing School of Software & Design, Brian Heim and I are involved in a machine learning group. Near the end of the program, students are able to do a personal project. Brian and I chose to pool our resources to build a neural net from scratch.

## Project Goals
The goal we picked for our neural net was to predict fantasy football scores. This is an interesting problem, yet something we believe we can accomplish in the two weeks given for personal projects. While there are many fantasy football predictions with more time, money and data than us, this does not decrease our learning.

Learning about machine learning can be intimidating, and we want to make it more accessible. Additionally, given the relatively short timeframe students are at Turing it is difficult to maintain an institutional memory. By making this into a website, we hope to offer a resource to future students.

Given this, the goals of this project are (in order) -

#### 1. Learn how to build a neural net

#### 2. Document our process for future students of machine learning

#### 3. Accurately predict fantasy football scores

## Data

The data used for this project is taken from the [NFL Fantasy API](http://api.fantasy.nfl.com/v1/docs/service?serviceName=playersStats). The initial plan is to divide this up by player and position. Four weeks of stats for a player will be taken as input data, with an output of the fifth week's fantasy football score. With ~27,000 individual week performances, we believe we have sufficient data to train our neural net. However, with only 3,100 individual week performances for quarter backs, we may not be able to predict this position very accurately
