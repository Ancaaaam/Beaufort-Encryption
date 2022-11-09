%include "../include/io.mac"


section .text
    global beaufort
    extern printf
; void beaufort(int len_plain, char *plain, int len_key, char *key, char tabula_recta[26][26], char *enc) ;
beaufort:
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; len_plain
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; len_key
    mov edx, [ebp + 20] ; key (address of first element in matrix)
    mov edi, [ebp + 24] ; tabula_recta
    mov esi, [ebp + 28] ; enc
 
make_first_step:
    cmp byte [ebx], 0
    je recharge_eax
    ;;facem prima parte de criptare
    mov cl, byte [edx]
    mov byte [esi], cl
    inc ebx
    inc edx
    inc esi
    cmp byte [edx],0
    jne make_first_step
    je recharge_edx

recharge_edx:
    ;;punem in edx din nou tot key-ul
    mov edx,[ebp+20]
    jmp make_first_step

recharge_eax:
    ;; punem in eax lungimea sirului esi ca sa ajungem pe poz initiala in esi
    mov eax, [ebp + 8]
    sub esi,eax
    ;; punem in eax sirul nemodificat
    mov eax, [ebp+12]
    jmp make_second_step

;;acum avem in esi sirul modificat cu key
make_second_step:
    ;;daca suntem la sfarsitul sirului programul se termina
    cmp byte [eax], 0
    je test_end
    mov cl, byte [eax]
    mov dl, byte [esi]
    cmp dl,cl
    ja diff_big_small
    je equal
    jmp diff_small_big

diff_big_small:
    ;;caz in care un caracter din sirul modificat este mai mare
    ;;decat caraterul de pe aceeasi poz din sirul initial
    sub dl,cl
    add dl, 'A'
    mov byte [esi], dl
    inc esi
    inc eax
    jmp make_second_step

diff_small_big:
    ;;caz in care un caracter din sirul modificat este mai mic
    ;;decat caracterul de pe aceeasi poz din sirul initial
    sub cl,dl
    dec cl
    mov dl,cl
    mov cl,'Z'
    sub cl,dl
    mov byte [esi], cl
    inc esi
    inc eax
    jmp make_second_step

equal:
    ;;caz in care caracterele sunt egale
    mov byte [esi], 'A'
    inc esi
    inc eax
    jmp make_second_step

test_end:
    ;;nothing here
    popa
    leave
    ret
