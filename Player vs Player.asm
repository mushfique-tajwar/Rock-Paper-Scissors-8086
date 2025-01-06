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
    p1_win db "Player 1 wins!$"
    p2_win db "Player 2 wins!$"
    12_tie db "It's a tie!$"
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
pvp:
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
    cmp cl, ch
    je pvp_tie
    cmp cl, 1
    je player1_rock
    cmp cl, 2
    je player1_paper
    cmp cl, 3
    je player1_scissors
player1_rock:
    cmp ch, 2
    je pvp_lose
    jmp pvp_win
player1_paper:
    cmp ch, 3
    je pvp_lose
    jmp pvp_win
player1_scissors:
    cmp ch, 1
    je pvp_lose
    jmp pvp_win
pvp_tie:
    call new_line
    string_print 12_tie
    jmp pvp_new_game
pvp_lose:
    call new_line
    string_print p2_win
    jmp pvp_new_game
pvp_win:
    call new_line
    string_print p1_win
    jmp pvp_new_game
pvp_new_game:
    call new_line
    string_print new_game_prompt
    mov ah, 01h
    int 21h
    cmp al, 'Y'
    je pvp
    cmp al, 'y'
    je pvp
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
proc print_choice
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
