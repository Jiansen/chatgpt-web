ps -axf | grep pnpm | grep -v grep | awk '{print $1}' | xargs kill -9


xtimestamp() {
  date +"[%Y-%m-%d %H:%M:%S]"
}

#pnpm_start_command="pnpm start"

cd ./service
# Use 'stdbuf' to disable output buffering for real-time log appending
# nohup sh -c "stdbuf -i0 -o0 -e0 pnpm start 2>&1 | while IFS= read -r line; do printf '%s %s\n' \"$(timestamp)\" \"\$line\"; done" >> service_log.log &
# nohup sh -c "stdbuf -i0 -o0 -e0 pnpm start 2>&1 | while IFS= read -r line; do printf '%s %s\n' \"[$(date '+%Y-%m-%d %H:%M:%S')]\" \"\$line\"; done" >> service_log.log &
nohup bash -c 'stdbuf -i0 -o0 -e0 $0 2>&1 | while IFS= read -r line; do printf "%s %s\n" "[$(date "+%Y-%m-%d %H:%M:%S")] " "$line"; done' "pnpm start" >> service_log.log &

# nohup pnpm start >> service_log.log &
echo "Start service complete!"


cd ..
echo "" >> front.log
# nohup sh -c "stdbuf -i0 -o0 -e0 sudo npm run dev 2>&1 | while IFS= read -r line; do printf '%s %s\n' \"$(timestamp)\" \"\$line\"; done" >> front.log &
# nohup sh -c "stdbuf -i0 -o0 -e0 sudo npm run dev 2>&1 | while IFS= read -r line; do printf '%s %s\n' \"[$(date '+%Y-%m-%d %H:%M:%S')]\"  \"\$line\"; done" >> front.log &
nohup bash -c 'stdbuf -i0 -o0 -e0 $0 2>&1 | while IFS= read -r line; do printf "%s %s\n" "[$(date "+%Y-%m-%d %H:%M:%S")] " "$line"; done' "sudo npm run dev" >> front.log &
# nohup pnpm dev >> front.log &
echo "Start front complete!"
tail -f front.log
