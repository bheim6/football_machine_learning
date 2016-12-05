This is a repository for Mind on the Ball, a Ruby neural net for predicting NFL football player performance. A website powered by this is located at [mind on the ball](http://mind-on-the-ball.herokuapp.com). For more discussion of neural nets, see the mind on the ball [blog](http://mind-on-the-ball.herokuapp.com/blog).

## Installation
* Clone down the repo
* rake db:{create,migrate,seed} (seeding pulls data from nfl fantasy api, will take awhile)

## Use
* launch rails console
* create a FootballPredictorService object
  * `predictor = FootballPredictorService.new({epoch: <number of epochs>, batch_size: <number of data sets in batch>, training_percentage: <percent of data used in training>})`
  * Even one epoch takes awhile, 10 is default batch size
* `predictor.learn`
  * This will start the predictor service learning. You can stop it with ctrl+c.
* When you are done with it learning,  save the neural net with StoredNeuralNet.store(predictor.nn)
* The neural net for predictions is loaded in the predictions controller, change the value of `nn`

## Versions
* Ruby - 2.3.0
* Ruby on Rails - 5.0.0.1
