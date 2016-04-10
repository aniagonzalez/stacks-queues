# class Hiring_Process
  require_relative './Stack.rb'
  require_relative './Queue.rb'

  @waiting = Queue.new
  @workers = Stack.new
  SPOTS = 6


  def self.wait_list(worker_id)
    # Adds individual workers to the waiting list (workers that are new to the process and have not been hired befored)
    @waiting.enqueue(worker_id)
  end

  def self.fill_spots
    # Hire people to fill all spots available
    SPOTS.times do
      hired = @waiting.dequeue
      @workers.push(hired)
    end
  end

  def self.fire_hire(number)
    # Validate that number is between 1 and 6 (a roll of dice)
    unless number > 0 && number < 7
      raise ArgumentError.new("Only numbers between 1 and 6 are allowed")
    end

    # Select worker that was the last to be hired, take them out of workers stack and move them to the end of waiting queue.
    # Do it one at a time so that they are enqued in the correct order until (fire_number) workers have completed the process.
    number.times do
      fired = @workers.pop
      if fired != nil
        @waiting.enqueue(fired)
      end
    end

    # Take the worker that was first in waiting list, take them out of queue and move them to the end of worker stack
    # Do it one at a time so that they are enqued in the correct order until (fire_number) workers have completed the process.
    number.times do
      hired = @waiting.dequeue
      @workers.push(hired)
    end
  end
