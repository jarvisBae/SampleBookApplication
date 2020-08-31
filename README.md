# My Bookshelf Application

![iOS 9.0+](https://img.shields.io/badge/iOS-9.0+-lightgray.svg) [![Languages](https://img.shields.io/badge/language-objc-blue.svg)](https://github.com/sendbird/sendbird-calls-ios)

도서 정보를 표시하는 어플리케이션
- 키워드 검색
- 메모
- url 하이퍼링크

## Screenshot

<img src="https://rftalk.s3.ap-northeast-2.amazonaws.com/sendbird/screenshop_01.png" width="20%" height="25%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img>
<img src="https://rftalk.s3.ap-northeast-2.amazonaws.com/sendbird/screenshop_02.png" width="20%" height="25%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img>
<img src="https://rftalk.s3.ap-northeast-2.amazonaws.com/sendbird/screenshop_03.png" width="20%" height="25%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img>
<img src="https://rftalk.s3.ap-northeast-2.amazonaws.com/sendbird/screenshop_04.png" width="20%" height="25%" title="px(픽셀) 크기 설정" alt="RubberDuck"></img>

## Demo

![Recordit GIF](http://g.recordit.co/YfLHsqqIpB.gif)


## 프로젝트 폴더 구성
- Utils: Category(swift extension), 데이터 저장 관련 기능
- Model : Model
- Views : Controller -> Page
- ViewModels : ViewModel
- Services : ServerAPI, Parse, Cache

## UnitTest
Books, BookDetail, 최근검색어 등이 정상적으로 호출 저장되지 체크
