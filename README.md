# 2024-NC2-M39-Wallet
# Apple Wallet을 활용한 명함 만들기

Apple Wallet에는 NFC로 결제하는 카드를 등록하는 기능이외에 바코드나 QR, 비행기티켓등을 저장할 수 있는 Pass가 있습니다.

**PassKit (Apple Pay and Wallet)**

앱에서 Apple Pay 결제를 처리하고 Wallet 앱용 패스를 생성 및 배포

PassKit API를 사용하여 Apple Pay를 지원하면 사용자는 앱을 떠나지 않고도 실제 상품과 서비스를 구매 가능

**Wallet Passes**

Wallet 앱용 패스를 생성, 배포, 업데이트합니다.

## pass

탑승권, 승차권, 멤버쉽카드, 쿠폰등을 활용할 수 있다.

한국에서 정식으로 지원하는 패스는 현재 applepay의 출시가 1년이 지난 시점에도 얼마 되지 않는다. 

> Applestore, 대한항공, 아시아나항공, 에어부산, 제주항공, 티웨이항공, 카카오페이 멤버십, 레고랜드 코리아 리조트, 이케아. 네스프레소, 아디다스, 케이스티파이, H&M, 스타벅스, 한국철도공사, 인터컨티넨탈 원 리워드 

위는 한국에서 정식으로 지원하는 패스이다. 

## 기술 토픽에서 집중한 부분과 그 이유

Wallet에 개인 카드 등을 넣기 위해서는 먼저 지류 카드의 정보를 패스화 시키는 과정에 대한 이해가 필요합니다.

이 과정은 passkit이 implement된 서드 파티 앱을 통해 가능하게 되기 때문에

저희는 **wallet pass**를 만들어 보는것에 집중하였고, 해당 기술에 대한 핵심적인 logic을 이해하고자

Apple developer에 서술된 방식을 통해 직접 입력한 정보를 바탕으로 Custom pass를 만드는 방법을

구현해보기로 결정했습니다.



## Pass파일 만들기

1. 지갑에 등록하려면 파일 확장자명이 .pkpass이다. pkpass파일을 만들기 위해서는 인증서를 통하여 서명을 해야한다. 서명을 하기전 파일은 pass이다.

   ![스크린샷 2024-06-19 20.15.34](/Users/tenedict/Library/Application Support/typora-user-images/스크린샷 2024-06-19 20.15.34.png)

2. 위는 애플 Developer Guide에 나오는 파일 형식이다. 

   pass 패키지 안에 저런 구조를 필요로 한다.

   ![스크린샷 2024-06-19 20.17.00](/Users/tenedict/Library/Application Support/typora-user-images/스크린샷 2024-06-19 20.17.00.png)

   그리고 패스의 모양마다 필요한 파일들이 다르다.

   > https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Creating.html#//apple_ref/doc/uid/TP40012195-CH4-SW1

3. 패스에 사용되는 레이아웃을 선택하고 Json파일 내의 양식을 활용해 작성하고 필요한 이미지 파일을 준비한다. 

   ```json
   {
         ...
         "passTypeIdentifier" : "
      your pass type identifier
      ",
          "teamIdentifier" : "
     your Team ID
      ",
          ...
     }
   ```

   

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

## 프로토타입

![스크린샷 2024-06-20 09.28.22](/Users/tenedict/Library/Application Support/typora-user-images/스크린샷 2024-06-20 09.28.22.png)

### 기능

 여러가지 정보나 이미지가 포함된 url, 갤러리를 공유할 때 디지털 명함을 만들어 빠르게 공유할 수 있습니다.

1. 디지털 명함에 들어갈 여러가지 정보를 입력합니다
2. 자신의 사진을 촬영하거나 갤러리에서 이미지를 추가하고
3. Add to Apple wallet 기능을 통해 wallet에 추가하면 Apple Wallet을 실행시켜 pass화 시킨 디지털 명함을 Apple wallet으로 보냅니다.

이러한 방법을 통해 커스텀된 디지털 명함을 만들 수 있습니다.

### 아직 프로토 타입인 이유

pass파일에 서명을 하는 과정을 위해 django와 연결을 했으나 django에서 서명을 하는 부분에서 계속 막혀서 아직 완성하지 못하였다.
