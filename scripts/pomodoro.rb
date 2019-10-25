#!/usr/bin/env ruby

require "yaml"

class Config
  attr_accessor :timer, :cycle, :rest
  attr_reader :filename

  def initialize(filename)
    @filename = filename
    load
  end

  def timer=(value)
    @chanded = true
    @timer = value
  end

  def cycle=(value)
    @changed = true
    @cycle = value
  end

  def rest=(value)
    @changed = true
    @rest = value
  end

  def load
    return unless File.exist? @filename

    newday = File.atime(@filename).day != Time.now.day

    configs = YAML.load_file @filename
    @timer = configs[:timer]
    @rest = configs[:rest] || false
    @cycle = newday ? 1 : (configs[:cycle] || 1)
    @changed = false
  end

  def save
    return unless @chanded
    data = {timer: self.timer, cycle: self.cycle, rest: self.rest}
    File.open(@filename, 'w') { |file| file.write data.to_yaml }
    @changed = false
    true
  end
end

current = Config.new "#{ENV['HOME']}/.config/pomodoro.yml"

def save_and_exit(current = {})
  current.save
  exit 0
end

case ENV['BLOCK_BUTTON']
when "1"
  current.timer = Time.now.to_i + (25 * 60) unless current.timer
when "3"
  current.timer = nil
  current.rest = false
end

icon = current.rest ? "" : ""

if current.timer
  counter = Time.at(current.timer - Time.now.to_i)

  if counter.to_i <= 0
    if current.rest
      current.timer = nil
      current.rest = false
      `notify-send 'Pomodoro' 'Break ended!'`
    else
      current.cycle = current.cycle.to_i + 1
      breaktime = (current.cycle % 5).zero? ? 15 : 5
      current.timer = Time.now.to_i + (breaktime * 60)
      current.rest = true
      # system "$HOME/.dotfiles/scripts/pomodoro_breaktime.sh &"
      `playerctl pause &`
      `notify-send 'Pomodoro' 'Break time!' &`
      `convert -size 1440x900 xc:White -gravity Center -font "Font-Awesome-5-Free-Solid" -weight 700 -pointsize 600 -fill "graya(50%, 0.5)" -annotate +300+0 "  " -fill black -font "DejaVu-Sans-Book" -weight 700 -pointsize 200  -annotate 0 "Break\nTime!" png:- | feh -FZYx - &`
    end
  end

  puts "#{icon}[#{counter.strftime('%M:%S')}]"
else
  puts "#{icon}[00:00]"
end

save_and_exit(current)
