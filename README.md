# 2024-NC2-M39-Wallet
# Apple Wallet을 활용한 명함 만들기

Apple Wallet에는 NFC로 결제하는 카드를 등록하는 기능이외에 바코드나 QR, 비행기티켓등을 저장할 수 있는 Pass가 있습니다.

## pass

탑승권, 승차권, 멤버쉽카드, 쿠폰등을 활용할 수 있다.

한국에서 정식으로 지원하는 패스는 현재 applepay의 출시가 1년이 지난 시점에도 얼마 되지 않는다. 

> Applestore, 대한항공, 아시아나항공, 에어부산, 제주항공, 티웨이항공, 카카오페이 멤버십, 레고랜드 코리아 리조트, 이케아. 네스프레소, 아디다스, 케이스티파이, H&M, 스타벅스, 한국철도공사, 인터컨티넨탈 원 리워드 

위는 한국에서 정식으로 지원하는 패스이다. 

Pass파일은 애플의 Developer 계정이 있다면 쉽게 만들 수 있다는 것을 알았고 직접 커스텀해서 Pass지갑에 추가하고 싶었다.



## Pass파일 만들기

1. 지갑에 등록하려면 파일 확장자명이 .pkpass이다. pkpass파일을 만들기 위해서는 인증서를 통하여 서명을 해야한다. 서명을 하기전 파일은 pass이다.

   ![스크린샷 2024-06-19 20.15.34](/Users/tenedict/Library/Application Support/typora-user-images/스크린샷 2024-06-19 20.15.34.png)

2. 위는 애플 Developer Guide에 나오는 파일 형식이다. 

   pass 패키지 안에 저런 구조를 필요로 한다.

   ![스크린샷 2024-06-19 20.17.00](/Users/tenedict/Library/Application Support/typora-user-images/스크린샷 2024-06-19 20.17.00.png)

   그리고 패스의 모양마다 필요한 파일들이 다르다.

   > https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1

3. 패스에 사용되는 레이아웃을 선택하고 Json파일 내의 양식을 활용해 작성하고 필요한 이미지 파일을 준비한다. 

4. pass파일이 준비되었다면 서명을 할 차례이다.

   1. 서명을 하기 위해서는 인증서를 준비해야한다. 
   2. Pass Type IDs 인증서를 준비하고 다운받는다.\
   3. 더블 클릭하여 애플 키체인에 등록한다.

5. 키체인에 인증서가 추가 되었으면 터미널과 사인패스 실행파일을 사용해서 서명할 수 있다.

6. 실행파일이 위치한 폴더에 pass파일을 만든다.(일반폴더이다.)

7. 터미널로 아래 명령어를 입력한다.

   ```
   ./signpass -p 폴더이름

8. pkpass확장자의 파일이 생성되어 있을 것 이다. 

### 내부 바코드, QR 형식

​	파일을 만들때 참고할 사항은 내부 QR 또는 바코드의 형식이다. 총 4가지 형식을 지원한다.

- PKBarcodeFormatQR
  - QR코드
- PKBarcodeFormatPDF417
  - 2차원 스택형 바코드
  - 여러줄의 바코드를 쌓은 상태
- PKBarcodeFormatAztec
  - 아즈텍코드
  - 2차원 매트릭스 바코드

- PKBarcodeFormatCode128
  - 1차원 형식의 바코드
