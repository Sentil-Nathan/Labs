import socket
 
# In this Line we define our local host
# address with port number
SERVER = "127.0.0.1"
PORT = 1234
# Making a socket instance
client = socket.socket(socket.AF_INET,
                       socket.SOCK_STREAM)
# connect to the server

client.connect((SERVER, PORT))
# Running a infinite loop
while True:
    print("Example : 4 + 5")
    # here we get the input from the user
    inp = input("Enter the operation in \
the form opreand operator oprenad: ")
    # If user wants to terminate the server connection he can type Over
    
    # Here we send the user input to server socket by send Method
    client.send(inp.encode())
    
    if inp == "Over":
        break
 
    # Here we receved output from the server socket
    answer = client.recv(1024)
    print("Answer is "+answer.decode())
    print("\nType 'Over' to terminate")
 
client.close()
