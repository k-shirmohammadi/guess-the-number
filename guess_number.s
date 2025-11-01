#.data
.data
#the instruction message
instructionMsg: .string "Welcome to Guess the Number game. If your guess difference is: \nin range 1-4, your guess is high or low. \nis more than 4, your guess is too high or too low.\n"
#the guess message
guessMsg: .string "\nPlease enter your guess: "
#the remaining attempts message
remainingAttemptsMsg: .string "\nYour remaining attempt(s): "
#the low message
lowMsg: .string "\nYour guess is low" 
#the too low message
tooLowMsg: .string "\nYour guess is too low"
#the high message
highMsg: .string "\nYour guess is high"
#the too high message
tooHighMsg: .string "\nYour guess is too high"
#the win message
winMsg: .string "\nYou Won!"
#the game over message
gameoverMsg: .string "\nYou Lost!"
#the correct answer message
correctAnswerMsg: .string "\nThe correct answer is "

#.text
.text
#print the instruction message
la a0, instructionMsg #load the instruction message in a0
addi a7, zero, 4
ecall
  
#generate a random number between 0 to 100 and store it in s0
addi a0, zero, 0 #set the lower bound to 0
addi a1, zero, 100 #set the upper bound to 100 
addi a7, zero, 42
ecall
  
add s0, zero, a0 #store the random number in s0
  
#set the amount of attempts
addi t1, zero, 3 #store 3 in t1

#set the range for being too low
addi t2, zero, -4 #store -4 in t2
#set the range for being too high
addi t3, zero, 4 #store 4 in t3

#make a loop
gameStatus_loop:

  #if t1 is equal to 0, branch to the label for game over 
  beqz  t1, status_gameover

  #print the remaining attempt message
  la a0, remainingAttemptsMsg #load the remaining attempt message in a0
  addi a7, zero, 4
  ecall
  
  #load the number of attempts (t1) in a0
  add a0, zero, t1
  addi a7, zero, 1
  ecall
  
  #print the guess message
  la a0, guessMsg #load the guess message in a0
  addi a7, zero, 4
  ecall
  
  #recieve input from the console and store it in s1
  addi a7, zero, 5
  ecall
  add s1, zero, a0

  #if s0 = s1, then branch to the label for win
  beq s0, s1, status_win

  #decrement the value from t1 by 1
  addi t1, t1, -1

  #set how far the input is from the random number
  sub s2, s1, s0 #calculate the difference between the numbers and store it in s2 (s1 - s0 = s2)
  
  #if s0 is too smaller than s1
  blt s2, t2, status_tooLow #if s2 is less than t2, then branch to label for too low status (s1 - s0 < -4)
  #if s0 is too higher than s1
  bgt s2, t3, status_tooHigh #if s2 is greater than t3, then branch to label for too high status (s1 - s0 > 4)
  #if s0 is smaller than s1 but not too much  
  bltz s2, status_low #if s2 is less than 0, then branch to label for low status (-4 < s1 - s0 < 0)
  #if s0 is greater than s1 but not too much
  bgtz s2, status_high #if s2 is greater than 0, then branch to label for high status (0 < s1 - s0 < 4)


#label low status 
status_low:
  #print the low message
  la a0, lowMsg #load the low message in a0
  jal printGameStatusMsg #jump to subroutine for printing the message of a game status
  
  j gameStatus_loop #jump back to the loop
  
#too low status label
status_tooLow:
  #print the too low message
  la a0, tooLowMsg #load the too low message in a0
  jal printGameStatusMsg #jump to subroutine for printing the message of a game status

  j gameStatus_loop #jump back to the loop
    
#high status label
status_high:
  #print the high message
  la a0, highMsg #load the high message in a0
  jal printGameStatusMsg #jump to subroutine for printing the message of a game status

  j gameStatus_loop #jump back to the loop
  
#too high status label
status_tooHigh:
  #print the too high message
  la a0, tooHighMsg #load the too high message in a0
  jal printGameStatusMsg #jump to subroutine for printing the message of a game status

  j gameStatus_loop #jump back to the loop
  
#label for win status
status_win:
  #print the win message
  la a0, winMsg #load the win message in a0
  addi a7, zero, 4
  ecall
  
  #jump to exit
  j exit

#label for game over status
status_gameover:
  #print the gameover message
  la a0, gameoverMsg #load the gameover message in a0
  addi a7, zero, 4
  ecall
 
  #print the correct answer message
  la a0, correctAnswerMsg #load the correct answer message in a0
  addi a7, zero, 4
  ecall

  #print the random number 
  add a0, zero, s0 #load the random number (s0) in a0
  addi a7, zero, 1
  ecall
     
#exit the program
exit:
  addi a7, zero, 10
  ecall

#subroutine for printing the messages corresponding to the game status
printGameStatusMsg:
  #print the message
  addi a7, zero, 4 
  ecall

  ret #return
