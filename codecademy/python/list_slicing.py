garbled = "!XeXgXaXsXsXeXmX XtXeXrXcXeXsX XeXhXtX XmXaX XI"


### long version (2 steps)
message = garbled
message = message[::2]
print message

message = message[::-1]
print message

### short version (1 step)
message = garbled
message = message[::-1].translate(None, "X")
print message


