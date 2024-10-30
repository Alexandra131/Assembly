extern array_idx_1      ;; int array_idx_1

section .text
    global inorder_parc

;   struct node {
;       int value;
;       struct node *left;
;       struct node *right;
;   } _attribute_((packed));

;;  inorder_parc(struct node *node, int *array);
;       functia va parcurge in inordine arborele binar de cautare, salvand
;       valorile nodurilor in vectorul array.
;    @params:
;        node  -> nodul actual din arborele de cautare;
;        array -> adresa vectorului unde se vor salva valorile din noduri;

; ATENTIE: vectorul array este INDEXAT DE LA 0!
;          Cititi SI fisierul README.md din cadrul directorului pentru exemple,
;          explicatii mai detaliate!
; HINT: folositi variabila importata array_idx_1 pentru a retine pozitia
;       urmatorului element ce va fi salvat in vectorul array.
;       Este garantat ca aceasta variabila va fi setata pe 0 la fiecare
;       test.

inorder_parc:

    push ebp
    mov ebp, esp
    pusha
    ;pun pe toate registrele zero
    xor ebx, ebx
    xor ecx, ecx
    xor eax, eax
    xor edx, edx
    xor esi, esi
    xor edi, edi
    mov edx, 1
    mov eax, [ebp +8]
    mov ebx, eax
   cmp dword [ebp+8], 0 ;pointerul catre nod este sau nu este nul
    jne nod_stang
    je final

nod_stang_drept:
    lea ecx, [ebx + 4*edx]  ; adresa pt nodul drept/stang
    push dword [ebp + 12] ; adresa el pt apel recursiv
    push dword [ecx] ;val elementurlui pentru apel recursiv
    call inorder_parc ;apel recursiv pentru nod drept/stang
    add esp, 8
    cmp edx, 1 ;verific daca executia a facut pentru nod stang sau drept
    jle radacina ; daca a fost pentru nod stang mergem in radacina
    jmp final ;daca a fost pentru nod drept

nod_stang:
    xor edx, edx
    mov edx, 1              ; edx = 1 pentru apelul nodului stâng
    jmp nod_stang_drept


radacina:
    mov esi, [ebp + 12] ;adresa element curent
    mov edi, [array_idx_1]
    add dword [array_idx_1], 1 ; adaugam un el vectorului
    xor eax, eax ;eax = 0
    mov eax, [ebx]
    mov [esi + 4*edi], eax
    xor edx, edx
    mov edx, 2              ; edx = 2 pentru apelul nodului drept
    jmp nod_stang_drept

final:
    popa
    leave
    ret

 ;pentru acest task am parcurs srd arborele, si am pus pe rand 
 ;informatia intr-un vector, prima data fiind nodul stang, radacina si 
 ;nodul drept   