# push_swap_tester

## Directory
```
|
|- [ push_swap ]
|	|- Makefile (Your push_swap Makefile)
|
|- [ push_swap_tester ]
|	|- push_swap_tester.bash
|	|- random_numbers.cpp
|	|- Makefile
|
```
## Note
### 한국어
- push_swap 프로젝트 디렉토리 명이 'push_swap'이 아니면 bash 파일에 적힌 push_swap 경로를 여러분의 디렉토리로 교체하거나 디렉토리명을 'push_swap'으로 바꾸세요.  
- 제가 이메일을 잘 확인하지 않는 관계로, 개선사항이나 오류 보고는 슬랙으로 해주세요. 제 개인 연락처를 알고계신다면 그냥 카카오톡이나 문자, 전화도 상관없습니다.  
- 지지고 볶고 마음대로 하십시오. 왜냐하면 업데이트를 장담할 수 없기 때문에ㅎㅎ;; 출처만 남겨주세요.
- random_numbers.cpp 를 컴파일해서 임의의 숫자 조합을 만들어낼 수 있습니다.
	- ```<숫자 범위 최솟값>```과 ```<숫자 범위 최댓값>```은 선택적인 인자입니다. 기본값은 ```0 ~ (<요소 개수> - 1)``` 입니다.
	```
	bash
	clang++ random_numbers.cpp -o random_numbers
	export ARG=$(./random_numbers <요소 개수> [숫자 범위의 최솟값] [숫자 범위의 최댓값])
	<push_swap directory>/push_swap $ARG | <push_swap directory>/checker $ARG
	<push_swap directory>/push_swap $ARG | wc-l
	```

	- 사용례
	```
	bash
	clang++ random_numbers.cpp -o random_numbers
	export ARG=$(./random_numbers 100 1)
	../push_swap/push_swap $ARG | ../push_swap/checker $ARG
	../push_swap/push_swap $ARG | wc -l
	```
### English
- If the name of your push_swap project directory is not 'push_swap', replace the push_swap path written in the bash file with your directory, or change the name of your directroy to 'push_swap'
- I don't check my e-mail very well, so please report improvements or errors with Slack. If you know my personal contact information, I don't mind just Kakao Talk, text message, or phone calls.
- You can make random numbers with random_numbers.cpp.
	- ```<range min>``` and ```<range max>``` is optional argument. Default is ```0 ~ (<number of elements> - 1)```.
	```
	bash
	clang++ random_numbers.cpp -o random_numbers
	export ARG=$(./random_numbers <number of elements> [range min] [range max])
	<push_swap directory>/push_swap $ARG | <push_swap directory>/checker $ARG
	<push_swap directory>/push_swap $ARG | wc-l
	```

	- example
	```
	bash
	clang++ random_numbers.cpp -o random_numbers
	export ARG=$(./random_numbers 100 1)
	../push_swap/push_swap $ARG | ../push_swap/checker $ARG
	../push_swap/push_swap $ARG | wc -l
	```
## Install & run
```
git clone git@github.com:minckim42/push_swap_tester.git
cd push_swap_tester
./push_swap_tester.bash
```
## Update
- 2021-03-22:
	- 오류가 발생하는 경우(Error를 출력해야 하는 경우)표준출력이 아닌 표준오류에 출력해야 통과되도록 함
	- makefile 메시지 감춤
	- bash 파일에 적힌 디렉토리 구조가 잘못되어 있었는데, 올바르게 고침
- 2021-03-15: birthday