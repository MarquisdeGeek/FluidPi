#!/bin/bash
# start/stop service and create pid file for a non-daemon app
# from https://blog.sleeplessbeastie.eu/2014/11/04/how-to-monitor-background-process-using-monit/

# test the audio
function playnote() {
  NOTE=$1

  echo "noteon 1 $NOTE 100" >  /dev/tcp/localhost/9988
  sleep 0.2
  echo "noteoff 1 $NOTE" >  /dev/tcp/localhost/9988
}

# service command
service_cmd="nice -n -19 fluidsynth -is -o "shell.port=9988" --gain 2 --audio-driver=alsa  -z=2048 /usr/share/sounds/sf2/FluidR3_GM.sf2"

# pid file location
service_pid="/var/run/fluidsynth.pid"

if [ $# -eq 1 -a  "$1" = "start" ]; then
  if [ -f "$service_pid" ]; then
    kill -0 $(cat $service_pid) 2>/dev/null # check pid
    if [ $? -eq 0 ]; then
      exit 2; # process is running, exit
    else
      unlink $service_pid # process is not running
                          # remove stale pid file
    fi
  fi

  # start service in background and store process pid
  $service_cmd >/dev/null &
  echo $! > $service_pid
  sleep 10
  aconnect 20:0 128:0

  playnote 60
  playnote 67
  playnote 72


elif  [ $# -eq 1 -a "$1" = "stop" -a -f "$service_pid" ]; then
  kill -0 $(cat $service_pid) 2>/dev/null # check pid
  if [ $? -eq 0 ]; then
    kill $(cat $service_pid) # kill process if it is running
  fi
  unlink $service_pid
  aconnect -x
fi
