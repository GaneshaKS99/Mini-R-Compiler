
files = open("inputfortarget.txt","r")
import re				
count = 0			# the count of the registers R1, R2 and so on

def build():			# generating upto 14 registers.
    global count
    count = (count + 1) % 14
    return 'R'+str(count)



data = {}			#dictionary to hold the registers and their value

def verify(l,r):		#to verify whether lhs and rhs are there or not
    try:
        r_l = data[elem[2]]
    except:
        r_l = build()
        data[elem[2]] = r_l
        movld(elem[2],r_l)
        
    try:
        r_r = data[elem[4]]
    except:
        r_r = build()
        data[elem[4]] = r_r
        movld(elem[4],r_r)

    return (r_l,r_r)

def movld(val,reg):
    if(val.isdigit()):
        print("MOV "+reg+",#"+val)
    elif(val.isalnum()):
       print("LD "+reg+","+val) 



cond = ['<','>','>=','<=','!=','==']	#only conditional operators

def store(val,reg):
    print("ST "+val+","+reg)

for i in files.readlines():
    line = i.strip()			#removes the front and back spaces
        
    if(re.search("^L[0-9]{1,2}",line)):
        print(line)
    elif(re.search("^goto",line)):
        print("BR "+line.split(' ')[1])
    elif(re.search("ifFalse",line)):
	    print(line.split('goto')[1])

    elif(re.search("t[0-9]{1,2}\s*=\s*",line)):
        elem = line.split(' ')		
    
        if(elem[3] in cond):
            reg = build()
            r_l,r_r = verify(elem[2],elem[4])          
            print("SUB "+reg+","+r_l+","+r_r)
            if(elem[3] == '>='):
                print("BLEZ "+reg+",",end='')
            elif(elem[3] == '<='):
                print("BGEZ "+reg+",",end='')
            elif(elem[3] == '=='):
                print("BEQ "+reg+",",end='')
            elif(elem[3] == '<'):
                print("BGTZ "+reg+",",end='')
            elif(elem[3] == '>'):
                print("BLTZ "+reg+",",end='')
            elif(elem[3] == '!='):
                print("BNE "+reg+",",end='')	    

    elif(re.search("[a-zA-Z][_a-zA-Z0-9]*",line)):
        elem = line.split(' ')
        try:
            temp = data[elem[2]]
        except:
                temp = build()
                movld(elem[2],temp)
                data[elem[2]] = temp
        store(elem[0],temp)
        data[elem[0]] = temp  
