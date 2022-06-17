.686
.model flat,stdcall
.stack 100h
.data

array dd 5.0, 3.0, 2.0
	  dd 7.0, 4.0, 11.0
	  dd 22.0, 42.0, 6.0

n dd 3;число строк
m dd 3;число столбцов

i dd 0;счётчик строк
j dd 0;счётчик столбцов
j_inv dd 0.0;


mysize dd 4;


SUM dd 0.0;сумма чисел по главной диагонали

nol dd 0.0
two dd 2.0
five dd 5.0

temp dd 0.0
.code
ExitProcess PROTO STDCALL :DWORD
Start:
	finit;

	;внешний цикл
	L1:
		mov j, 0;
		xor eax, eax;
		xor ebx, ebx;
		xor ecx, ecx;
		
		L2:
			mov eax, i;
			mov ebx, j;

			cmp eax, ebx;
			je L3;
			jne L4;

			L3:
				xor eax, eax;
				;address calculate
				mov eax, m;
				mul i;
				add eax, j;
				mul mysize;
				;use eax
				fld array[eax];
				fld SUM;
				fadd;
				fstp SUM;

			L4:

				inc j;
				mov ecx, j;
				mov ebx, m;
				cmp ecx, ebx;
				jne L2;

		inc i;
		mov ecx, i;
		mov ebx, n;
		cmp ecx, ebx;
		jne L1;

		fld nol
		fld two
		fld SUM
		fprem;деление по модулю st на st(1)
		fcomi st, st(2);сравниваем остаток с 0
		je L5;

		fstp temp;
		fstp temp;

		fld five;
		fld SUM;
		fprem;деление по модулю st на st(1)
		fcomi st, st(2);сравниваем остаток с 0
		je L5;
		jne L6;

		L5:
			fstp temp;
			fstp temp;
			;переставляем элементы главной и побочной диагоналей
			mov i, 0;
			mov j, 0;

			;внешний цикл
	L7:
		mov j, 0;
		xor eax, eax;
		xor ebx, ebx;
		xor ecx, ecx;
		
		L8:
			mov eax, i;
			mov ebx, j;

			cmp eax, ebx;
			je L9;
			jne L10;

			L9:
				xor eax, eax;
				;address calculate
				mov eax, m;
				mul i;
				add eax, j;
				mul mysize;
				;use eax
				fld array[eax];

				xor eax, eax;
				;address calculate
				mov eax, m;
				mul i;
				mov ecx, m
				mov j_inv, ecx;
				mov ebx, j_inv;
				sub ebx, j;
				sub ebx, 1;
				mov j_inv, ebx;
				xor ebx, ebx;
				add eax, j_inv;
				mul mysize;
				;use eax
				fld array[eax];

				xor eax, eax;
				;address calculate
				mov eax, m;
				mul i;
				add eax, j;
				mul mysize;
				;use eax
				fstp array[eax];
				
				xor eax, eax;
				;address calculate
				mov eax, m;
				mul i;
				mov ecx, m;
				mov j_inv, ecx;
				mov ebx, j_inv;
				sub ebx, j;
				sub ebx, 1;
				mov j_inv, ebx;
				xor ebx, ebx;
				add eax, j_inv;
				mul mysize;
				;use eax
				fstp array[eax];
			L10:

				inc j;
				mov ecx, j;
				mov ebx, m;
				cmp ecx, ebx;
				jne L8;

		inc i;
		mov ecx, i;
		mov ebx, n;
		cmp ecx, ebx;
		jne L7;



		L6:
			;конец программы



exit:
Invoke ExitProcess,1
End Start
