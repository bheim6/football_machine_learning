class FootballPredictorService
  attr_reader :batch,
              :epoch,
              :batch_size,
              :error,
              :nn,
              :training_percentage

  def initialize(learning_details)
    @batch = {}
    @batch[:input] = []
    @batch[:output] = []
    @epoch = learning_details[:epoch]
    @batch_size ||= learning_details[:batch_size] || 10
    @error = learning_details[:error]
    @nn = NeuralNet.new(48,30,12)
    @training_percentage ||= learning_details[:training_percentage] || 0.95
  end

  def learn
    current_epoch = 0
    training_count = (training_percentage * PlayerWeekStat.count).round(0)
    while current_epoch < epoch
      training_set = PlayerWeekStat.all.to_a.pop(training_count)
      while training_set.count >= batch_size
        get_batch(training_set, batch_size)
        learn_on_batch
      end
      current_epoch += 1
    end
  end

  private
    def learn_on_batch
      nn.initial_activation = batch[:input]
      nn.learn_within_error(batch[:output], error)
      clear_batch
    end

    def clear_batch
      batch[:input] = []
      batch[:output] = []
    end

    def get_batch(training_set, batch_size)
      while batch[:input].count < batch_size && training_set.count > 0
        get_single_batch(training_set)
      end
    end

    def get_single_batch(training_set)
      output = training_set.shuffle!.pop
      begin
        input = DataPrepService.last_four_normalized_games(output.season_week, output.player).flatten
        batch[:input] << input
        batch[:output] << DataPrepService.normalize_stats(output.stats_array)
      rescue
        if training_set.count > 0
          get_single_batch(training_set)
        else
          return batch
        end
      end
    end
end
