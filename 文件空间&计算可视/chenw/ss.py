#!/usr/bin/python
import threading
import socket
from pynteractive import *
import time
 
# encoding = 'utf-8'
encoding = 'utf-8'
BUFSIZE = 1024
 
# a read thread, read data from remote
class Reader(threading.Thread):
    def __init__(self, client):
        threading.Thread.__init__(self)
        self.client = client
        
    def run(self):
        while True:
            data = self.client.recv(BUFSIZE)
            if(data):
                if data == 'start\n':
                    lev1 = 'ratings'
                    lev2_1, lev2_2 = 'target', 'others'
                    lev3_1, lev3_2, lev3_3, lev3_4 = 'thumm02','thumm03','thumm04','thumm05'

                    myG.addNode(lev1,shape='database',color='blue')

                    time.sleep(2)
                    myG.addNode(lev2_1,shape='circle')
                    myG.addNode(lev2_2,shape='circle')
                    myG.addEdge(lev1,lev2_1)
                    myG.addEdge(lev1,lev2_2)

                    time.sleep(2)
                    for i in [lev3_1, lev3_2, lev3_3, lev3_4]:
                        myG.addNode(i, shape='circle',color='green')
                        myG.addEdge(lev2_2, i)

                    time.sleep(2)
                    for i in [lev3_1, lev3_2, lev3_3, lev3_4]:
                        myG.addEdge(lev2_1, i)
                elif data == 'finish\n':
                    print data
                else:
                    # print data
                    data_record = []
                    temp = data.strip().split('\n')
                    for lines in temp:
                        t1, t2 = lines.split()
                        data_record.append(t1)
                        myG.addNode(t1, shape='dot')
                        myG.addEdge(t2, t1)

                    time.sleep(6)
                    myG.addNode('Tasktracker', shape='circle', color='green')
                    for i in range(len(data_record)):
                        myG.addEdge(data_record[i], 'Tasktracker',label='map')

                    time.sleep(3)
                    myG.addNode('Result', shape='circle', color='red')
                    myG.addEdge('Tasktracker', 'Result', label='reduce', width=2)
            else:
                break
        # print("close:", self.client.getpeername())
 
# a listen thread, listen remote connect
# when a remote machine request to connect, it will create a read thread to handle
class Listener(threading.Thread):
    def __init__(self, port):
        threading.Thread.__init__(self)
        self.port = port
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.sock.bind(("0.0.0.0", port))
        self.sock.listen(0)
    def run(self):
        # print("listener started")
        while True:
            client, cltadd = self.sock.accept()
            Reader(client).start()
            # cltadd = cltadd
            # print("accept a connect")
 
lst  = Listener(9527)   # create a listen thread
lst.start() # then start

myG = Graph(directed=True)
myG.view()


