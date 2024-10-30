extern array_idx_2      ;; int array_idx_2

section .text
    global inorder_intruders

;   struct node {
;       int value;
;       struct node *left;
;       struct node *right;
;   } __attribute__((packed));

;;  inorder_intruders(struct node *node, struct node *parent, int *array)
;       functia va parcurge in inordine arborele binar de cautare, salvand
;       valorile nodurilor care nu respecta proprietatea de arbore binar
;       de cautare: |node->value > node->left->value, daca node->left exista
;                   |node->value < node->right->value, daca node->right exista
;
;    @params:
;        node   -> nodul actual din arborele de cautare;
;        parent -> tatal/parintele nodului actual din arborele de cautare;
;        array  -> adresa vectorului unde se vor salva valorile din noduri;

; ATENTIE: DOAR in frunze pot aparea valori gresite!
;          vectorul array este INDEXAT DE LA 0!
;          Cititi SI fisierul README.md din cadrul directorului pentru exemple,
;          explicatii mai detaliate!

; HINT: folositi variabila importata array_idx_2 pentru a retine pozitia
;       urmatorului element ce va fi salvat in vectorul array.
;       Este garantat ca aceasta variabila va fi setata pe 0 la fiecare
;       test al functiei inorder_intruders.      

inorder_intruders:
    push ebp
    mov ebp, esp
    pusha
    ;initializez cu zero toate registrele
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    mov eax, [ebp + 8]
    cmp dword [ebp+8], 0 
    je final
    mov edx, 1 ; folosesc 1 cand sun pe nod stanga
    jmp stang_drept
 
stang_drept:
    lea ecx, [eax + 4*edx] ;adresa element stang/drept
    push dword [ebp + 16] 
    push dword [ebp + 8] 
    push dword [ecx]
    call inorder_intruders ;apel recursiv in functie de ce nod avem
    add esp, 12
    cmp edx, 1 ;verific ce fel de nod am avut, stang sau drept
    jle nodul_pe_care_ma_aflu ;am avut nod stang
    jmp final ; am avut nod drept
 
fiu_drept:
    mov edx,2  ; folosesc 2 cand sunt pe nod dreapta
    cmp [edi], eax ;comparare nod cu parinte
    jg nod_drept 
    jmp pune_val


nodul_pe_care_ma_aflu:
    mov esi, [ecx] ;valoare nod stang
    mov edi, [ecx+4] ; valoare nod drept
    xor edx, edx
    mov edx, 0
    cmp esi, edx ;in cazul in care avem frunza
    jne nod_drept
    cmp edi, edx
    jne nod_drept
    mov edx, 4
    mov ebx, [ebp + 2*edx +4] 
    mov esi, [ebx + edx]
    mov edi, [ebp + 2*edx] ;nodul drept
    mov eax, [ebx] ;in eax tin parintele
    cmp edi, esi
    jne fiu_drept ;margem pe fiul drept/ cand 
    xor edx, edx
    mov edx, 1  
    cmp [edi], eax
    jl nod_drept
    jmp pune_val

nod_drept:
    mov edx, 2 ;atunci cand ma aflu pe un nod drept
    mov eax, [ebp + 8]
    jmp stang_drept
 
pune_val: 
; punem valoarea in vector in cazul in care
;nu indeplineste conditia
    mov ecx, [ebp + 16]
    mov edx, [array_idx_2]
    add dword [array_idx_2], 1
    xor eax, eax
    mov eax, [edi]
    mov [ecx + 4 * edx], eax
    jmp nod_drept

final:
    popa
    leave
    ret

; pentru acest task la fel ca la taskul anterior am parcurs
;arborele srd, iar in cazul in care frunza nu indeplinea 
;conditia de arbore binar de cautare, adaugam valoarea respectiva 
; in vector, frunza din drapta trebuia sa fie mai mare decat radacina sa
;frunza din stanga mai mica dacat radacina sa, altfel se adauga in vector    