import socket, time
import numpy as np
import logging

class TCPIP():
    def __init__(self, tcpip_address, tcpip_port=6666, tcpip_terminator='\n'):

        self.tcpip_address = tcpip_address
        self.tcpip_port = tcpip_port
        self.tcpip_terminator = tcpip_terminator

        # setup socket
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.settimeout(10.0)
        try:
            self.socket.connect((self.tcpip_address, self.tcpip_port))
        except socket.timeout:
            logging.warning('Socket not connected.')    

    def send(self, msg, delay=1.0):
        try:
            # msg : a JSON-formatted string
            self.socket.send(msg.encode(encoding='utf-8'))
            self.socket.send(self.tcpip_terminator.encode(encoding='utf-8'))
        except TimeoutError:
            logging.warning('Message did not send.')
          
        try:
            r = self.socket.recv(3)
            if r.decode('UTF8') != '_ok':
                logging.warning('Communication issue.')
            else:
                self._reconnect()
        except socket.timeout:
            logging.warning('No reply from remote, re-establish connection.')

    def end(self):
        self.socket.close()

    def reconnect(self):
        print 'Press reconnect button on remote computer...'
        self._reconnect()
    def _reconnect(self):
        #print ('Click reconnect on remote computer...')
        self.socket.close()
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.settimeout(10.0)
        try:
            self.socket.connect((self.tcpip_address, self.tcpip_port))
        except socket.timeout:
            logging.warning('Socket not connected.')    

        #print('Reconnected.')

if __name__ == '__main__':
    address = '128.112.217.150'
    t = TCPIP(address)
