import socket
from datetime import date
 
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
    if msg == "Over":
        print("Connection is Over")
        break
 
    print("DOB is recievied")
    
    dob = msg.split('/')
    year = int(dob[0])
    month = int(dob[1])
    day = int(dob[2])
    
    bday=date(year,month,day)
    
    today = date.today()
    age = today.year - bday.year -((today.month, today.day) <(bday.month, bday.day))
    
    print("Send the result to client")
    # Here we change int to string and
    # after encode send the output to client
    output = str(age)
    clientConnection.send(output.encode())
clientConnection.close()
