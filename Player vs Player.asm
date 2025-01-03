.model small
string_print macro string
    lea dx, string
    mov ah, 09h
    int 21h
endm
.stack 100h
.data
    prompt_player1 db "Player 1, choose Rock (1), Paper (2), or Scissors (3): $"
    prompt_player2 db "Player 2, choose Rock (1), Paper (2), or Scissors (3): $"
    invalid_input db "Invalid input! Please press 1, 2, or 3.$"
    result_lose db "Player 1 wins!$"
    result_win db "Player 2 wins!$"
    result_tie db "It's a tie!$"
    new_game_prompt db "Play again? (Y/N): $"
    player1_choice_msg db "Player 1 chose: $"
    player2_choice_msg db "Player 2 chose: $"
    rock_msg db "Rock$"
    paper_msg db "Paper$"
    scissors_msg db "Scissors$"
.code
proc main
    mov ax, @data
    mov ds, ax
game_loop:
    call new_line
    string_print prompt_player1
get_player1_input:
    mov ah, 08h
    int 21h
    sub al, 30h
    cmp al, 1
    je valid_input_player1
    cmp al, 2
    je valid_input_player1
    cmp al, 3
    je valid_input_player1
    ; Invalid input
    call new_line
    string_print invalid_input
    call new_line
    string_print prompt_player1
    jmp get_player1_input
valid_input_player1:
    mov cl, al
    call new_line
    string_print prompt_player2
get_player2_input:
    mov ah, 08h
    int 21h
    sub al, 30h
    cmp al, 1
    je valid_input_player2
    cmp al, 2
    je valid_input_player2
    cmp al, 3
    je valid_input_player2
    ; Invalid input
    call new_line
    string_print invalid_input
    call new_line
    string_print prompt_player2
    jmp get_player2_input
valid_input_player2:
    mov ch, al    
    call new_line
    string_print player1_choice_msg
    mov al, cl
    call print_choice
    call new_line
    string_print player2_choice_msg
    mov al, ch
    call print_choice
    ; Game logic
    cmp ch, dl
    je tie
    cmp ch, 1     
    je rock_case
    cmp ch, 2    
    je paper_case
    cmp ch, 3      
    je scissors_case
rock_case:
    cmp cl, 1      
    je tie
    cmp cl, 2     
    je lose
    jmp win
paper_case:
    cmp cl, 1     
    je win
    cmp cl, 2   
    je tie
    jmp lose
scissors_case:
    cmp cl, 1    
    je lose
    cmp cl, 2    
    je win
    jmp tie
tie:
    call new_line
    string_print result_tie
    jmp new_game
lose:
    call new_line
    string_print result_lose
    jmp new_game
win:
    call new_line
    string_print result_win
    jmp new_game
new_game:
    call new_line
    string_print new_game_prompt
    mov ah, 01h
    int 21h
    cmp al, 'Y'      
    je game_loop     
    cmp al, 'y'      
    je game_loop      
    ; Exit
    mov ax, 4C00h       
    int 21h

proc new_line
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    ret
endp new_line
print_choice proc
    cmp al, 1
    je print_rock
    cmp al, 2
    je print_paper
    cmp al, 3
    je print_scissors
    ret
print_rock:
    string_print rock_msg
    ret
print_paper:
    string_print paper_msg
    ret
print_scissors:
    string_print scissors_msg
    ret
endp print_choice
end main
