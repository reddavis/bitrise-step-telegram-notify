#!/bin/bash
set -ex

# echo "This is the value specified for the input 'example_step_input': ${example_step_input}"

#
# --- Export Environment Variables for other Steps:
# You can export Environment Variables for other Steps with
#  envman, which is automatically installed by `bitrise setup`.
# A very simple example:
# envman add --key EXAMPLE_STEP_OUTPUT --value 'the value you want to share'
# Envman can handle piped inputs, which is useful if the text you want to
# share is complex and you don't want to deal with proper bash escaping:
#  cat file_with_complex_input | envman add --KEY EXAMPLE_STEP_OUTPUT
# You can find more usage examples on envman's GitHub page
#  at: https://github.com/bitrise-io/envman

#
# --- Exit codes:
# The exit code of your Step is very important. If you return
#  with a 0 exit code `bitrise` will register your Step as "successful".
# Any non zero exit code will be registered as "failed" by `bitrise`.


# We only want to send successful builds
if [ $BITRISE_BUILD_STATUS -ne 0 ] ; then exit 0 ; fi

RESULT=$(curl -X POST https://api.telegram.org/bot${telegram_bot_token}/sendMessage \
-H "Content-Type: application/json" \
-d @- <<EOF
{
    "chat_id":"${telegram_chat_id}", 
    "text":"${custom_message}",
    "parse_mode":"HTML"
}
EOF)
