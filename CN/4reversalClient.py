import socket
 
# In this Line we define our local host
# address with port number
SERVER = "127.0.0.1"
PORT = 8080
# Making a socket instance
client = socket.socket(socket.AF_INET,
                       socket.SOCK_STREAM)
# connect to the server
client.connect((SERVER, PORT))
# Running a infinite loop
while True:
    # here we get the input from the user
    inp = input("Enter the string to be reversed: ")
    # If user wants to terminate
    # the server connection he can type Over
    
    # Here we send the user input
    # to server socket by send Method
    client.send(inp.encode())
    
    if inp == "-1":
        break
 
    # Here we receved output from the server socket
    answer = client.recv(1024)
    print("Reversed String is "+answer.decode())
    print("\nType '-1' to terminate")
 
client.close()
