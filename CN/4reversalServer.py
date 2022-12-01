import socket
 
# Here we use localhost ip address
# and port number
LOCALHOST = "127.0.0.1"
PORT = 8080
# calling server socket method
server = socket.socket(socket.AF_INET,
                       socket.SOCK_STREAM)
server.bind((LOCALHOST, PORT))
server.listen(1)
print("Server started")
print("Waiting for client request..")
# Here server socket is ready for
# get input from the user
clientConnection, clientAddress = server.accept()
print("Connected client :", clientAddress)
msg = ''
# Running infinite loop
while True:
    data = clientConnection.recv(1024)
    msg = data.decode()
    if msg == "-1":
        print("Connection is Over")
        break
 
    print("String is receivied")
    
    print("Send the result to client")
    # Here we change int to string and
    # after encode send the output to client
    output = msg[::-1]
    
    clientConnection.send(output.encode())
clientConnection.close()
