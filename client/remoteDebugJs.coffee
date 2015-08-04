class RemoteConsole
  constructor: () ->
    @socket = new WebSocket 'ws://127.0.0.1:8081/'
  log: () ->
    @send 'LOG', arguments
  error: () ->
    @send 'ERROR', arguments
  warn: () ->
    @send 'WARN', arguments
  info: () ->
    @send 'INFO', arguments
  doSend: (type, data) ->
    @socket.send JSON.stringify {
      type: type,
      data: data
    }
    false
  send: (type, data) ->
    that = this
    setTimeout () ->
      if that.socket.readyState == 1 then that.doSend type, data else that.send type, data
    ,5

window.console = new RemoteConsole;

x = {
  p1: 'p1',
  p2: 'p2satatatat'
}

console.log 'a', 'b', 'c', 'd'
console.error 'a', 'b', 'c', 'd'
console.warn 'a', 'b', 'c', 'd'
console.info 'a', 'b', 'c', 'd', x, x