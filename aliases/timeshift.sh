# Timeshift snapshot with confirmation & logging
ts-create() {
  local comment="${*:-Manual snapshot $(date +"%Y-%m-%d %H:%M")}"
  local cmd="sudo timeshift --create --comments \"$comment\""
  local logfile="$HOME/.ts-create.log"

  echo "🕒 Preparing to create a Timeshift snapshot..."
  echo "---------------------------------------------"
  echo "Command to be executed:"
  echo "$cmd"
  echo "---------------------------------------------"

  if [ -n "$ZSH_VERSION" ]; then
    read "confirm?⚠️  Proceed with this command? (Y/N): "
  else
    read -p "⚠️  Proceed with this command? (Y/N): " confirm
  fi

  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "✅ Executing Timeshift snapshot..."
    eval "$cmd"
    local status="Executed"
  else
    echo "❌ Operation cancelled."
    local status="Cancelled"
  fi

  # Log entry
  {
    echo "---------------------------------------------"
    echo "Date: $(date +"%Y-%m-%d %H:%M:%S")"
    echo "Comment: $comment"
    echo "Status: $status"
    echo "---------------------------------------------"
  } >> "$logfile"

  echo "📝 Logged to: $logfile"
}
