#!/usr/bin/env python

import os
import subprocess, urlparse
import SimpleHTTPServer, SocketServer
PORT = 4040

class MyHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):

    def do_GET(self):
        parsedParams = urlparse.urlparse(self.path)
        parsed_query = urlparse.parse_qs(parsedParams.query)
        url = parsed_query['i'][0]
        self.send_response(204)

        os.system('pkill mpv') #only one

        subprocess.Popen(
            [
                'mpv',
                '--mute=no', # always start muted
                '--loop=inf', # loop by default
                '--no-native-fs',
                url
            ],
            stdout=subprocess.PIPE
        )

Handler = MyHandler
httpd = SocketServer.TCPServer(('', PORT), Handler)
print "serving at port ", PORT
httpd.serve_forever()
